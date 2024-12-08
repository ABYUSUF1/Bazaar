import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repo/auth_repo.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authRepo) : super(SignInInitial());

  final AuthRepo _authRepo;

  // Sign in with email and password
  Future<void> signIn({required String email, required String password}) async {
    emit(SignInLoading());
    final result = await _authRepo.signInWithEmailAndPassword(
        email: email, password: password);
    result.fold(
      (failure) => emit(SignInFailure(failure.errMessage)),
      (user) => emit(SignInSuccess()),
    );
  }
}
