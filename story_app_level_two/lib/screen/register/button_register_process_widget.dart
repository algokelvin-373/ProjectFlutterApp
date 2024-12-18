import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_level_two/utils/snack_bar_helper.dart';

import '../../data/model/register/register_request.dart';
import '../../provider/auth/auth_provider.dart';
import '../../static/auth_result.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            final msgFailedRegister =
                AppLocalizations.of(context)!.failedRegister;
            final snackBarHelper = SnackBarHelper(context);
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
                snackBarHelper.showMessage(errorState.error, Colors.red);
              } else {
                snackBarHelper.showMessage(msgFailedRegister, Colors.red);
              }
            } else {
              snackBarHelper.showMessage(result.message, Colors.green);
              widget.onRegister();
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
        child: Text(
          AppLocalizations.of(context)!.register,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
