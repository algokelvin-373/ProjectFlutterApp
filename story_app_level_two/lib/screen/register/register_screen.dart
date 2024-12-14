import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_level_two/data/model/register/register_request.dart';
import 'package:story_app_level_two/provider/auth/auth_provider.dart';
import 'package:story_app_level_two/utils/global_function.dart';

import '../../static/auth_result.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const RegisterScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              /*Row(
              children: [
                IconButton(
                  onPressed: () {

                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ],
            ),*/
              spaceVertical(20),
              Center(
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    //color: Colors.white,
                  ),
                ),
              ),
              spaceVertical(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onRegister();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              TextField(
                controller: _fullNameController,
                //style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Full Name',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _emailController,
                //style: TextStyle(color: Colors.white),
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
                controller: _passwordController,
                obscureText: true,
                //style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Set Password',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              spaceVertical(30),
              context.watch<AuthProvider>().isLoadingRegister
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final scaffoldMessage =
                                ScaffoldMessenger.of(context);
                            final request = RegisterRequest(
                              name: _fullNameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            final authRegister = context.read<AuthProvider>();
                            await authRegister.register(request);
                            final result =
                                await authRegister.getResultRegister();
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
                    ),
              spaceVertical(20),
            ],
          ),
        ),
      ),
    );
  }
}
