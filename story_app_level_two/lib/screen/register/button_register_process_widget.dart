import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/register/register_request.dart';
import '../../provider/auth/auth_provider.dart';
import '../../static/auth_result.dart';

class ButtonRegisterProcessWidget extends StatefulWidget {
  final Function() onRegister;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const ButtonRegisterProcessWidget({
    super.key,
    required this.onRegister,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  State<ButtonRegisterProcessWidget> createState() =>
      _ButtonRegisterProcessWidgetState();
}

class _ButtonRegisterProcessWidgetState
    extends State<ButtonRegisterProcessWidget> {
  @override
  Widget build(BuildContext context) {
    return context.watch<AuthProvider>().isLoadingRegister
        ? const Center(child: CircularProgressIndicator())
        : btnRegisterAction();
  }

  Widget btnRegisterAction() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (widget.formKey.currentState!.validate()) {
            final scaffoldMessage = ScaffoldMessenger.of(context);
            final request = RegisterRequest(
              name: widget.fullNameController.text,
              email: widget.emailController.text,
              password: widget.passwordController.text,
            );
            final authRegister = context.read<AuthProvider>();
            await authRegister.register(request);
            final result = await authRegister.getResultRegister();
            if (result.error) {
              final errorState = authRegister.resultState;
              if (errorState is AuthErrorState) {
                scaffoldMessage.showSnackBar(SnackBar(
                  content: Text(
                    errorState.error,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ));
              } else {
                scaffoldMessage.showSnackBar(SnackBar(
                  content: Text(
                    "Failed for Register",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ));
              }
            } else {
              scaffoldMessage.showSnackBar(SnackBar(
                content: Text(
                  result.message,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ));
              widget.onRegister();
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
        child: Text('Register', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
