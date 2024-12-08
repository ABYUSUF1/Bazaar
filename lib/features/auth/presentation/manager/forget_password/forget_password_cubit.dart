import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repo/auth_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._authRepo) : super(ForgetPasswordInitial());

  final AuthRepo _authRepo;

  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());
    final result = await _authRepo.forgetPassword(email);

    result.fold(
      (failure) => emit(ForgetPasswordFailure(failure.errMessage)),
      (user) => emit(ForgetPasswordSuccess()),
    );
  }
}
