import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_level_two/static/auth_result.dart';

import '../../data/model/login/login_request.dart';
import '../../provider/auth/auth_provider.dart';

class ButtonLoginProcessWidget extends StatefulWidget {
  final Function() onLogin;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const ButtonLoginProcessWidget({
    super.key,
    required this.onLogin,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<ButtonLoginProcessWidget> createState() =>
      _ButtonLoginProcessWidgetState();
}

class _ButtonLoginProcessWidgetState extends State<ButtonLoginProcessWidget> {
  @override
  Widget build(BuildContext context) {
    return context.watch<AuthProvider>().isLoadingLogin
        ? const Center(child: CircularProgressIndicator())
        : btnLoginAction();
  }

  Widget btnLoginAction() {
    final authProvider = Provider.of<AuthProvider>(context);
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (widget.formKey.currentState != null &&
              widget.formKey.currentState!.validate()) {
            final scaffoldMessage = ScaffoldMessenger.of(context);
            final request = LoginRequest(
              email: widget.emailController.text,
              password: widget.passwordController.text,
            );

            await context.read<AuthProvider>().login(request);

            final result = authProvider.isLoggedIn;
            if (result) {
              scaffoldMessage.showSnackBar(
                SnackBar(
                  content: Text(
                    'Login Success',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              widget.onLogin();
            } else {
              final errorState = authProvider.resultState;
              if (errorState is AuthErrorState) {
                scaffoldMessage.showSnackBar(
                  SnackBar(
                    content: Text(
                      errorState.error,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                scaffoldMessage.showSnackBar(
                  SnackBar(
                    content: Text(
                      "Your email or password is invalid",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text('Log In', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
