import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/pages/auth_pages/log_in_page.dart';
import 'package:social/providers/themes_provider.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/widgets/profile/cutom_profile_button.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: AppMethods.boderRadius(radius: 20),
      ),
      position: PopupMenuPosition.under,
      iconColor: color,
      onSelected: (value) async {
        if (value == 'log Out') {
          await FirebaseAuth.instance.signOut();
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, LogInPage.routName);
          }
        }
        if (value == 'themes') {
          themeProvider.setDarkTheme(themeValue: !themeProvider.getIsDarkTheme);
          if (context.mounted) {
            Navigator.canPop(context);
          }
        } else {
          if (context.mounted) {
            AppMethods.showUserImageError(context, null,
                error: 'nothing to do');
          }
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: 'log Out',
            child: CutomProfileButton(
              iconData: Icons.logout_outlined,
              title: 'Log Out',
            ),
          ),
          PopupMenuItem<String>(
            value: 'themes',
            child: CutomProfileButton(
              title: '${themeProvider.getIsDarkTheme ? 'Light' : 'Dark'} Mode',
              iconData: themeProvider.getIsDarkTheme
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
        ];
      },
    );
  }
}
