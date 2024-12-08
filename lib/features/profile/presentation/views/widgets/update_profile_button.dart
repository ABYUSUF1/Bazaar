import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/profile/profile_cubit.dart';
import '../../manager/profile/profile_state.dart';

class UpdateProfileButton extends StatelessWidget {
  final AuthEntity authEntity;

  const UpdateProfileButton({super.key, required this.authEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        return ValueListenableBuilder<bool>(
          valueListenable: cubit.hasChangesNotifier,
          builder: (context, hasChanges, child) {
            return TextButton(
              onPressed: hasChanges
                  ? () => cubit.updateProfile(authEntity: authEntity)
                  : null,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                backgroundColor: hasChanges
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withOpacity(0.3),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: hasChanges && state is ProfileLoading
                  ? const CircularProgressIndicator(color: AppColors.whiteColor)
                  : Text(
                      "Update Profile",
                      style: AppTextStyles.style14W600.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
