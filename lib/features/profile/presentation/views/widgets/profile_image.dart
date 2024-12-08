import 'package:bazaar/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;

  const ProfileImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(imageUrl),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton.filled(
            onPressed: () async {
              // Pick image
              final pickedFile = await ImagePicker().pickImage(
                source: ImageSource.gallery,
                maxWidth: 200,
                maxHeight: 200,
              );
              if (pickedFile != null) {
                final base64Image = await pickedFile.readAsBytes();
              }
            },
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primaryColor.withOpacity(0.4),
              foregroundColor: AppColors.whiteColor,
            ),
            icon: const Icon(Icons.camera_alt_outlined),
          ),
        ),
      ],
    );
  }
}
