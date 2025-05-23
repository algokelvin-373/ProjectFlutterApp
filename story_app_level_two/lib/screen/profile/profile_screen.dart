import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_level_two/provider/auth/auth_provider.dart';
import 'package:story_app_level_two/utils/global_function.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileUserScreen extends StatefulWidget {
  final Function() onLogout;

  const ProfileUserScreen({super.key, required this.onLogout});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.username == '') {
      authProvider.loadUser();
    }

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.profileUser)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'images/ic_profile.jpg',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              (authProvider.username == '') ? '...' : authProvider.username,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            spaceVertical(20),
            authWatch.isLoadingLogout
                ? const CircularProgressIndicator()
                : btnLogoutAction(),
            spaceVertical(20),
          ],
        ),
      ),
    );
  }

  Widget btnLogoutAction() {
    return ElevatedButton(
      onPressed: () async {
        final msgSuccess = AppLocalizations.of(context)!.successLogout;
        final msgFailed = AppLocalizations.of(context)!.failedLogout;
        final scaffoldMessage = ScaffoldMessenger.of(context);
        final authRead = context.read<AuthProvider>();
        final result = await authRead.logout();
        if (result) {
          scaffoldMessage.showSnackBar(
            SnackBar(
              content: Text(
                msgSuccess,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.onLogout();
        } else {
          scaffoldMessage.showSnackBar(
            SnackBar(
              content: Text(
                msgFailed,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 120, vertical: 5),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        AppLocalizations.of(context)!.logout,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
