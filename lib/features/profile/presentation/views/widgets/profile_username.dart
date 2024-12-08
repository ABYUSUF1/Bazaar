import 'package:bazaar/core/utils/auth_validator.dart';
import 'package:bazaar/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/profile/profile_cubit.dart';

class ProfileUsername extends StatelessWidget {
  final String username;
  const ProfileUsername({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
            title: "Username",
            controller: context.read<ProfileCubit>().usernameController,
            hintText: username,
            validator: (value) =>
                AuthValidator.validateUsername(value?.trim() ?? '')),
      ],
    );
  }
}
