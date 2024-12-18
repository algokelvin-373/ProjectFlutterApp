import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:story_app_level_two/screen/login/login_body_screen.dart';

class LoginScreen extends StatelessWidget {
  final Function() onLogin;
  final Function() onRegister;

  const LoginScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
          if (!snapshot.hasData) return Container();
          PackageInfo? packageInfo = snapshot.data;
          return Center(
            child: SingleChildScrollView(
              child: LoginBodyScreen(
                onLogin: onLogin,
                onRegister: onRegister,
                packageInfo: packageInfo,
              ),
            ),
          );
        },
      ),
    );
  }
}
