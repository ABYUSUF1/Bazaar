import 'package:bazaar/features/auth/domain/entities/auth_entity.dart';
import 'package:bazaar/features/profile/domain/repo/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial()) {
    // Initialize controllers
    usernameController.addListener(_onInputChange);
    phoneNumberController.addListener(_onInputChange);
    birthdayController.addListener(_onInputChange);
  }

  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final birthdayController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // ValueNotifier to track if there are unsaved changes
  ValueNotifier<bool> hasChangesNotifier = ValueNotifier<bool>(false);

  // Method to track changes
  void _onInputChange() {
    // Update the ValueNotifier based on the form input
    hasChangesNotifier.value = usernameController.text.isNotEmpty ||
        phoneNumberController.text.isNotEmpty ||
        birthdayController.text.isNotEmpty;
  }

  Future<void> saveUserData(AuthEntity authEntity) async {
    emit(ProfileLoading());
    final result = await profileRepo.saveUserData(authEntity);
    result.fold(
      (failure) => emit(ProfileFailure(failure.errMessage)),
      (_) => emit(ProfileSuccess(authEntity)),
    );
  }

  Future<void> loadUserData(String uid) async {
    emit(ProfileLoading());
    final result = await profileRepo.getUserData(uid);
    result.fold(
      (failure) => emit(ProfileFailure(failure.errMessage)),
      (authEntity) => emit(ProfileSuccess(authEntity)),
    );
  }

  Future<void> updateProfile({required AuthEntity authEntity}) async {
    emit(ProfileLoading());

    if (usernameController.text.isEmpty ||
        usernameController.text == authEntity.username) {
      usernameController.text = authEntity.username;
    }
    if (phoneNumberController.text.isEmpty ||
        phoneNumberController.text == authEntity.phoneNumber) {
      phoneNumberController.text = authEntity.phoneNumber!;
    }
    if (birthdayController.text.isEmpty ||
        birthdayController.text == authEntity.birthday) {
      birthdayController.text = authEntity.birthday!;
    }

    final result = await profileRepo.updateUserData(
      username: usernameController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      birthday: birthdayController.text.trim(),
      profileImage: null,
      userId: authEntity.id,
    );

    result.fold((failure) => emit(ProfileFailure(failure.errMessage)),
        (success) {
      // Update the ValueNotifier when data is updated
      hasChangesNotifier.value = false;

      // load the new data
      loadUserData(authEntity.id);

      emit(ProfileSuccess(authEntity)); // Or use success to reset changes
    });
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    phoneNumberController.dispose();
    birthdayController.dispose();
    hasChangesNotifier.dispose();
    return super.close();
  }
}
