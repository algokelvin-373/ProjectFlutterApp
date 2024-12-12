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
  State<ButtonLoginProcessWidget> createState() => _ButtonLoginProcessWidgetState();
}

class _ButtonLoginProcessWidgetState extends State<ButtonLoginProcessWidget> {
  @override
  Widget build(BuildContext context) {
    return context.watch<AuthProvider>().isLoadingLogin
        ? const Center(child: CircularProgressIndicator())
        : btnLoginAction();
        /*: Center(
            child: ElevatedButton(
              onPressed: () async {
                print('Click Login');
                if (widget.formKey.currentState != null &&
                    widget.formKey.currentState!.validate()) {
                  final scaffoldMessage = ScaffoldMessenger.of(context);
                  final request = LoginRequest(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  print('Login: email - ${_emailController.text}');
                  print('Login: pass - ${_passwordController.text}');

                  await context.read<AuthProvider>().login(request);

                  final result = authProvider.isLoggedIn;
                  if (result) {
                    print('Success Login');
                    widget.onLogin();
                  } else {
                    scaffoldMessage.showSnackBar(
                      const SnackBar(
                        content: Text("Your email or password is invalid"),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 120,
                  vertical: 15,
                ),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Log In',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );*/
  }

  Widget btnLoginAction() {
    final authProvider = Provider.of<AuthProvider>(context);
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          print('Click Login');
          if (widget.formKey.currentState != null &&
              widget.formKey.currentState!.validate()) {
            final scaffoldMessage = ScaffoldMessenger.of(context);
            final request = LoginRequest(
              email: widget.emailController.text,
              password: widget.passwordController.text,
            );
            print('Login: email - ${widget.emailController.text}');
            print('Login: pass - ${widget.passwordController.text}');

            await context.read<AuthProvider>().login(request);

            final result = authProvider.isLoggedIn;
            if (result) {
              print('Success Login');
              widget.onLogin();
            } else {
              final errorState = authProvider.resultState;
              if (errorState is AuthErrorState) {
                scaffoldMessage.showSnackBar(
                  SnackBar(content: Text(errorState.error)),
                );
              } else {
                scaffoldMessage.showSnackBar(
                  const SnackBar(
                    content:
                    Text("Your email or password is invalid"),
                  ),
                );
              }
            }
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 120,
            vertical: 15,
          ),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Log In',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
