import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_level_two/data/model/login/login_request.dart';
import 'package:story_app_level_two/provider/auth/auth_provider.dart';
import 'package:story_app_level_two/screen/login/button_login_process_widget.dart';
import 'package:story_app_level_two/utils/global_function.dart';

class LoginScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const LoginScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.shield,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),
                spaceVertical(20),
                Center(
                  child: Text(
                    'Sign in to your Account',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                spaceVertical(10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Click Sign Up');
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
                    //fillColor: Color(0xFF1C2A35),
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
                    suffixIcon: Icon(Icons.visibility),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    //fillColor: Color(0xFF1C2A35),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                spaceVertical(10),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Your Password?',
                      style: TextStyle(color: Colors.blue),
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
                /*context.watch<AuthProvider>().isLoadingLogin
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      print('Click Login');
                      if (formKey.currentState != null && formKey.currentState!.validate()) {
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
                              content:
                              Text("Your email or password is invalid"),
                            ),
                          );
                        }

                        //print('Value result - $result');
                        *//*if (result) {
                          print('Masuk if result');
                          widget.onLogin();
                        } else {
                          print('Masuk else login failed');
                          scaffoldMessage.showSnackBar(
                            const SnackBar(
                              content:
                              Text("Your email or password is invalid"),
                            ),
                          );
                        }*//*
                      } else {
                        print('Error formKey');
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
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
