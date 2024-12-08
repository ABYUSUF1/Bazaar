import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repo/auth_repo.dart';
part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit(this._authRepo) : super(GoogleSignInInitial());

  final AuthRepo _authRepo;

  // Sign in with google
  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoading());
    final result = await _authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(GoogleSignInFailure(failure.errMessage)),
      (success) => emit(GoogleSignInSuccess()),
    );
  }
}
