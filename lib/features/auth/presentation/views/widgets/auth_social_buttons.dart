import 'package:bazaar/core/utils/app_assets.dart';
import 'package:bazaar/features/auth/presentation/manager/google_sign_in/google_sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/services/get_it_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/widget/custom_snack_bar.dart';
import '../../../domain/repo/auth_repo.dart';

class AuthSocialButtons extends StatelessWidget {
  const AuthSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GoogleButton(),
      ],
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleSignInCubit(
        getIt<AuthRepo>(),
      ),
      child: BlocConsumer<GoogleSignInCubit, GoogleSignInState>(
        listener: (context, state) {
          if (state is GoogleSignInFailure) {
            showErrorSnackBar(context: context, errMessage: state.errMessage);
          } else if (state is GoogleSignInSuccess) {
            GoRouter.of(context).pushReplacement(AppRouter.home);
          }
        },
        builder: (context, state) {
          return TextButton(
            clipBehavior: Clip.hardEdge,
            onPressed: () {
              context.read<GoogleSignInCubit>().signInWithGoogle();
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              backgroundColor: AppColors.primaryColor2,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            ),
            child: state is GoogleSignInLoading
                ? const SizedBox.square(
                    dimension: 15,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ))
                : SvgPicture.asset(AppAssets.imagesIconsGoogle,
                    width: 22, height: 22),
          );
        },
      ),
    );
  }
}
