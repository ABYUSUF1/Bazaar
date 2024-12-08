import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final void Function()? onTap;
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
    this.hintText,
    this.onTap,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String _hintText() {
    if (widget.title == LocaleKeys.auth_email_address.tr()) {
      return LocaleKeys.auth_enter_your_email_address.tr();
    } else if (widget.title == LocaleKeys.auth_username.tr()) {
      return LocaleKeys.auth_enter_your_name.tr();
    } else {
      return '********';
    }
  }

  IconData _icon = Icons.visibility_off_outlined;
  IconButton? _suffixIcon() {
    if (LocaleKeys.auth_password.tr() == widget.title) {
      return IconButton(
        onPressed: () {
          setState(() {
            _icon = _icon == Icons.visibility_off_outlined
                ? Icons.remove_red_eye_outlined
                : Icons.visibility_off_outlined;
          });
        },
        icon: Icon(
          _icon,
          color: AppColors.foregroundColor,
        ),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: AppTextStyles.style14W600),
            const SizedBox(height: 4),
            TextField(
              controller: widget.controller,
              onTap: widget.onTap,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              onChanged: (value) => field.didChange(value),
              style: AppTextStyles.style14Normal,
              decoration: InputDecoration(
                hintText: widget.hintText ?? _hintText(),
                hintStyle: AppTextStyles.style14Normal
                    .copyWith(color: AppColors.foregroundColor2),
                enabledBorder: _outlineInputBorder(field.hasError
                    ? AppColors.errorColor
                    : AppColors.secondaryColor),
                focusedBorder: _outlineInputBorder(AppColors.primaryColor),
                focusedErrorBorder: _outlineInputBorder(AppColors.primaryColor),
                suffixIcon: _suffixIcon(),
              ),
              obscureText: LocaleKeys.auth_password.tr() == widget.title &&
                  _icon == Icons.visibility_off_outlined,
            ),
            const SizedBox(height: 8),
            field.hasError
                ? Row(
                    children: [
                      const Icon(Icons.warning,
                          color: AppColors.errorColor, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        field.errorText!,
                        style: AppTextStyles.style12Normal.copyWith(
                          color: AppColors.errorColor,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }

  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }
}
