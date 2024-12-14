import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/core/widget/custom_snack_bar.dart';
import 'package:bazaar/features/auth/domain/repo/auth_repo.dart';
import 'package:bazaar/features/auth/presentation/manager/sign_out/sign_out_cubit.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../services/get_it_service.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_router.dart';

class DrawerLogoutButton extends StatelessWidget {
  const DrawerLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignOutCubit(getIt<AuthRepo>()),
      child: BlocConsumer<SignOutCubit, SignOutState>(
        listener: (context, state) {
          if (state is SignOutSuccess) {
            GoRouter.of(context).pushReplacementNamed(AppRouter.auth);
          }
          if (state is SignOutFailure) {
            showErrorSnackBar(context: context, errMessage: state.errMessage);
          }
        },
        builder: (context, state) {
          return TextButton(
            onPressed: () async {
              // Logout
              await context.read<SignOutCubit>().signOut();
            },
            style: TextButton.styleFrom(
                minimumSize: const Size(280, 50),
                backgroundColor: AppColors.errorColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            child: state is SignOutLoading
                ? const CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.imagesIconsLogout,
                          color: AppColors.whiteColor),
                      const SizedBox(width: 20),
                      Text(
                        LocaleKeys.auth_logout.tr(),
                        style: AppTextStyles.style12Normal
                            .copyWith(color: AppColors.whiteColor),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
