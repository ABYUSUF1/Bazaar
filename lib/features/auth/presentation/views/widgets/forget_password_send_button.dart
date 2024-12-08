import 'dart:async';

import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/get_it_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widget/custom_snack_bar.dart';
import '../../../domain/repo/auth_repo.dart';
import '../../manager/forget_password/forget_password_cubit.dart';

class ForgetPasswordSendButton extends StatelessWidget {
  final TextEditingController emailController;
  final GlobalKey<FormState> forgetPasswordFormKey;
  const ForgetPasswordSendButton(
      {super.key,
      required this.emailController,
      required this.forgetPasswordFormKey});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(getIt<AuthRepo>()),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordFailure) {
            showErrorSnackBar(context: context, errMessage: state.errMessage);
          } else if (state is ForgetPasswordSuccess) {
            showSuccessSnackBar(
                context: context,
                sucMessage: LocaleKeys.auth_password_sended_successfully.tr());
          }
        },
        builder: (context, state) {
          return _ButtonUI(
            onPressed: () => context
                .read<ForgetPasswordCubit>()
                .forgetPassword(emailController.text.trim()),
            isLoading: state is ForgetPasswordLoading,
            forgetPasswordFormKey: forgetPasswordFormKey,
          );
        },
      ),
    );
  }
}

class _ButtonUI extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final GlobalKey<FormState> forgetPasswordFormKey;
  const _ButtonUI(
      {required this.onPressed,
      required this.isLoading,
      required this.forgetPasswordFormKey});

  @override
  State<_ButtonUI> createState() => _ButtonUIState();
}

class _ButtonUIState extends State<_ButtonUI> {
  int _countDown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountDown();
  }

  void _startCountDown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countDown > 0) {
          _countDown--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (_countDown == 0 &&
              widget.forgetPasswordFormKey.currentState!.validate()) {
            widget.onPressed();
            setState(() {
              _countDown = 60; // Reset countdown after resending
              _startCountDown(); // Restart the timer
            });
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: _countDown == 0
              ? AppColors.primaryColor
              : AppColors.foregroundColor2,
          foregroundColor: AppColors.whiteColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: _buildText(isLoading: widget.isLoading, countDown: _countDown));
  }

  Widget _buildText({required bool isLoading, required int countDown}) {
    if (isLoading) {
      return const SizedBox.square(
        dimension: 17,
        child: CircularProgressIndicator(color: AppColors.whiteColor),
      );
    } else {
      return Text(countDown == 0
          ? LocaleKeys.auth_send.tr()
          : LocaleKeys.auth_wait_60_sec
              .tr(namedArgs: {'countDown': countDown.toString()}));
    }
  }
}
