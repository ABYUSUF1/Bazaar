import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repo/auth_repo.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit(this._authRepo) : super(VerifyEmailInitial());

  final AuthRepo _authRepo;

  Future<void> verifyEmail() async {
    emit(VerifyEmailLoading());
    final result = await _authRepo.verifyEmail();
    result.fold(
      (failure) => emit(VerifyEmailFailure(failure.errMessage)),
      (user) => emit(VerifyEmailSuccess()),
    );
  }
}
