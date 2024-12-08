import 'package:bazaar/core/widget/bazaar_drawer/drawer_account_section.dart';
import 'package:bazaar/core/widget/bazaar_drawer/drawer_help_and_support_section.dart';
import 'package:bazaar/core/widget/bazaar_drawer/drawer_logout_button.dart';
import 'package:bazaar/core/widget/bazaar_drawer/drawer_profile_section.dart';
import 'package:bazaar/core/widget/bazaar_drawer/drawer_settings_section.dart';
import 'package:flutter/material.dart';

import 'drawer_personalization_section.dart';

class BazaarDrawer extends StatelessWidget {
  const BazaarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      width: 300,
      child: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ///* Profile Section [Header]
            DrawerProfileSection(),
            Divider(),
            SizedBox(height: 20),

            ///* Account Section
            DrawerAccountSection(),
            SizedBox(height: 20),

            //* personalization Section
            DrawerPersonalizationSection(),
            SizedBox(height: 20),

            ///* Settings Section
            DrawerSettingsSection(),
            SizedBox(height: 20),

            ///* Help & Support Section
            DrawerHelpAndSupportSection(),
            SizedBox(height: 40),

            ///* Logout Button
            DrawerLogoutButton(),
          ],
        ),
      )),
    );
  }
}
