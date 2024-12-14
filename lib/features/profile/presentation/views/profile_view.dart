import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/profile/profile_cubit.dart';
import '../manager/profile/profile_state.dart';
import 'widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.auth_profile.tr()),
        ),
        body:
            BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileFailure) {
            return Center(child: Text(state.errMessage));
          } else if (state is ProfileSuccess) {
            final authEntity = state.authEntity;
            return ProfileViewBody(authEntity: authEntity);
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        }));
  }
}
