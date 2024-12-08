import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'facebook_sign_in_state.dart';

class FacebookSignInCubit extends Cubit<FacebookSignInState> {
  FacebookSignInCubit() : super(FacebookSignInInitial());
}
