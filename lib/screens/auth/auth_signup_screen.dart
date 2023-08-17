import 'package:flutter/material.dart';
import 'package:media_tooker/screens/auth/login_screen.dart';
import 'package:media_tooker/widgets/button_widget.dart';
import 'package:media_tooker/widgets/textfield_widget.dart';

class AuthScreen extends StatelessWidget {
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final emailController = TextEditingController();

  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextFieldWidget(label: 'Email', controller: emailController),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                    showEye: true,
                    isObscure: true,
                    label: 'Password',
                    controller: passwordController),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                    showEye: true,
                    isObscure: true,
                    label: 'Confirm Password',
                    controller: confirmpasswordController),
                const SizedBox(
                  height: 30,
                ),
                ButtonWidget(
                  color: Colors.amber[800],
                  radius: 100,
                  label: 'Done',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
