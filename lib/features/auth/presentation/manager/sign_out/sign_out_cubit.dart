import 'package:bazaar/features/auth/domain/repo/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit(this._authRepo) : super(SignOutInitial());

  final AuthRepo _authRepo;

  Future<void> signOut() async {
    emit(SignOutLoading());

    try {
      final result = await _authRepo.signOut();

      result.fold(
        (failure) {
          emit(SignOutFailure(failure.errMessage));
        },
        (_) {
          emit(SignOutSuccess());
        },
      );
    } catch (e) {
      emit(SignOutFailure('An error occurred: ${e.toString()}'));
    }
  }
}
