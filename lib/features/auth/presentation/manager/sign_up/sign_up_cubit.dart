import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repo/auth_repo.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepo) : super(SignUpInitial());

  final AuthRepo _authRepo;

  Future<void> signUp({required String email, required String password}) async {
    emit(SignUpLoading());
    final result = await _authRepo.createNewAccountWithEmailAndPassword(
        email: email, password: password);
    result.fold(
      (failure) => emit(SignUpFailure(failure.errMessage)),
      (user) => emit(SignUpSuccess()),
    );
  }
}
