import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_level_two/static/auth_result.dart';
import 'package:story_app_level_two/utils/snack_bar_helper.dart';

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
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    bool isMobileConnection = connectivityResult[0].name == ConnectivityResult.mobile.name;
    bool isWifiConnection = connectivityResult[0].name == ConnectivityResult.wifi.name;
    if (isMobileConnection || isWifiConnection) {
      setState(() {
        isConnected = true;
      });
    } else {
      setState(() {
        isConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<AuthProvider>().isLoadingLogin
        ? const Center(child: CircularProgressIndicator())
        : btnLoginAction();
  }

  Widget btnLoginAction() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final snackBarHelper = SnackBarHelper(context);
          final authProvider = context.read<AuthProvider>();
          await _checkInternetConnection();
          if (isConnected) {
            if (widget.formKey.currentState != null &&
                widget.formKey.currentState!.validate()) {
              final request = LoginRequest(
                email: widget.emailController.text,
                password: widget.passwordController.text,
              );

              await authProvider.login(request);

              final result = authProvider.isLoggedIn;
              if (result) {
                final message = 'Login Success';
                snackBarHelper.showMessage(message, Colors.green);
                widget.onLogin();
              } else {
                final errorState = authProvider.resultState;
                if (errorState is AuthErrorState) {
                  snackBarHelper.showMessage(errorState.error, Colors.red);
                } else {
                  final message = "Your email or password is invalid";
                  snackBarHelper.showMessage(message, Colors.red);
                }
              }
            }
          } else {
            final message = "No Internet Connection";
            snackBarHelper.showMessage(message, Colors.red);
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
