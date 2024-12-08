import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/profile/presentation/manager/profile/profile_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/profile/presentation/manager/profile/profile_state.dart';
import '../../utils/app_router.dart';

class DrawerProfileSection extends StatelessWidget {
  const DrawerProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is ProfileSuccess) {
          final authEntity = state.authEntity;
          return ListTile(
            onTap: () {
              GoRouter.of(context).pushNamed(AppRouter.profile);
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: authEntity.photoUrl!,
                width: 40,
                height: 40,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: AppColors.errorColor),
              ),
            ),
            title: Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Hi,',
                  style: AppTextStyles.style10NormalLightGrey
                      .copyWith(color: AppColors.foregroundColor)),
              TextSpan(
                  text: ' ${authEntity.username}',
                  style: AppTextStyles.style14Normal),
            ])),
            subtitle: Text(authEntity.email,
                style: AppTextStyles.style10NormalLightGrey),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded,
                color: AppColors.greyColor),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
