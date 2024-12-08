import 'package:bazaar/core/utils/app_text_styles.dart';
import 'package:bazaar/features/auth/domain/entities/auth_entity.dart';
import 'package:bazaar/features/profile/presentation/manager/profile/profile_cubit.dart';
import 'package:bazaar/features/profile/presentation/views/widgets/profile_birthday.dart';
import 'package:bazaar/features/profile/presentation/views/widgets/profile_image.dart';
import 'package:bazaar/features/profile/presentation/views/widgets/profile_phone_number.dart';
import 'package:bazaar/features/profile/presentation/views/widgets/update_profile_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_username.dart';

class ProfileViewBody extends StatelessWidget {
  final AuthEntity authEntity;
  const ProfileViewBody({super.key, required this.authEntity});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<ProfileCubit>().formKey,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width > 400 ? 400 : 350),
          child: Column(
            children: [
              // Profile Image
              ProfileImage(imageUrl: authEntity.photoUrl!),
              const SizedBox(height: 5),

              // user's Email
              Text(authEntity.email, style: AppTextStyles.style16Bold),
              const SizedBox(height: 50),

              /// user's username
              ProfileUsername(username: authEntity.username),
              const SizedBox(height: 20),

              // user's phone number
              ProfilePhoneNumber(phoneNumber: authEntity.phoneNumber!),
              const SizedBox(height: 20),

              // user's birth date
              ProfileBirthday(birthday: authEntity.birthday!),
              const SizedBox(height: 20),

              // Save button
              UpdateProfileButton(authEntity: authEntity)
            ],
          ),
        ),
      ),
    );
  }
}
