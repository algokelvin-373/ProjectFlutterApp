import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:story_app_level_two/flavor_config.dart';

import '../../utils/global_function.dart';
import 'button_login_process_widget.dart';

class LoginBodyScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;
  final PackageInfo? packageInfo;

  const LoginBodyScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
    required this.packageInfo,
  });

  @override
  State<LoginBodyScreen> createState() => _LoginBodyScreenState();
}

class _LoginBodyScreenState extends State<LoginBodyScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(Icons.work_history, size: 60, color: Colors.blue),
              ),
              spaceVertical(20),
              Center(
                child: Text(
                  'Sign in to your Account',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              spaceVertical(10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onRegister();
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              spaceVertical(30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              spaceVertical(15),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              spaceVertical(20),
              ButtonLoginProcessWidget(
                onLogin: widget.onLogin,
                formKey: formKey,
                emailController: _emailController,
                passwordController: _passwordController,
              ),
              spaceVertical(30),
              Center(
                child: Text(
                  "Version: ${widget.packageInfo?.version} - ${FlavorConfig.instance.flavor.name}",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              Center(
                child: Text(
                  "App Name: ${widget.packageInfo?.appName}",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
