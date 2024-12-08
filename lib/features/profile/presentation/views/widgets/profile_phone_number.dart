import 'package:bazaar/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:bazaar/features/profile/presentation/manager/profile/profile_cubit.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/auth_validator.dart';

class ProfilePhoneNumber extends StatelessWidget {
  final String phoneNumber;
  const ProfilePhoneNumber({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        title: LocaleKeys.auth_phone_number.tr(),
        hintText: phoneNumber.isEmpty ? "No Phone Number" : phoneNumber,
        controller: context.read<ProfileCubit>().phoneNumberController,
        validator: (value) =>
            AuthValidator.validatePhoneNumber(value?.trim() ?? ''));
  }
}
