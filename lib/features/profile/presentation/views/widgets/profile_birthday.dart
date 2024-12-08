import 'package:bazaar/core/utils/auth_validator.dart';
import 'package:bazaar/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../manager/profile/profile_cubit.dart';

class ProfileBirthday extends StatefulWidget {
  final String birthday;
  const ProfileBirthday({super.key, required this.birthday});

  @override
  State<ProfileBirthday> createState() => _ProfileBirthdayState();
}

class _ProfileBirthdayState extends State<ProfileBirthday> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final birthdayController = context.read<ProfileCubit>().birthdayController;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      _selectedDate = pickedDate;
      birthdayController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      title: LocaleKeys.auth_birthday.tr(),
      controller: context.read<ProfileCubit>().birthdayController,
      hintText: widget.birthday.isEmpty ? "No Birthday" : widget.birthday,
      onTap: () => _selectDate(context),
      validator: (value) => AuthValidator.validateBirthday(value?.trim() ?? ''),
    );
  }
}
