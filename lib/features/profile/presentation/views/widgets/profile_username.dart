import 'package:bazaar/core/utils/auth_validator.dart';
import 'package:bazaar/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
            title: LocaleKeys.auth_username.tr(),
            controller: context.read<ProfileCubit>().usernameController,
            hintText: username,
            validator: (value) =>
                AuthValidator.validateUsername(value?.trim() ?? '')),
      ],
    );
  }
}
