import 'dart:async';

import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/get_it_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widget/custom_snack_bar.dart';
import '../../../domain/repo/auth_repo.dart';
import '../../manager/verify_email/verify_email_cubit.dart';

class VerifyEmailButton extends StatelessWidget {
  const VerifyEmailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyEmailCubit(getIt<AuthRepo>()),
      child: BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
        listener: (context, state) {
          if (state is VerifyEmailFailure) {
            showErrorSnackBar(context: context, errMessage: state.errMessage);
          } else if (state is VerifyEmailSuccess) {
            showSuccessSnackBar(
                context: context,
                sucMessage: LocaleKeys.auth_verify_email_send.tr());
          }
        },
        builder: (context, state) {
          return _ButtonUI(
            onPressed: () => context.read<VerifyEmailCubit>().verifyEmail(),
            isLoading: state is VerifyEmailLoading,
          );
        },
      ),
    );
  }
}

class _ButtonUI extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  const _ButtonUI({required this.onPressed, required this.isLoading});

  @override
  State<_ButtonUI> createState() => _ButtonUIState();
}

class _ButtonUIState extends State<_ButtonUI> {
  int _countDown = 60;
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
          if (_countDown == 0) {
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
