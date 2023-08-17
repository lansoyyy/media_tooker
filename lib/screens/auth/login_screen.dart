import 'package:flutter/material.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/button_widget.dart';
import 'package:media_tooker/widgets/text_widget.dart';
import 'package:media_tooker/widgets/textfield_widget.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              text: 'Welcome!',
              fontSize: 48,
              color: primary,
              fontFamily: 'Bold',
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(label: 'Email', controller: emailController),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWidget(
                    isObscure: true,
                    showEye: true,
                    label: 'Password',
                    controller: passwordController),
                TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    decoration: TextDecoration.underline,
                    text: 'Forgot Password',
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              radius: 100,
              color: Colors.amber[800],
              label: 'Log In',
              onPressed: () {},
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: 125,
                  height: 45,
                  color: Colors.white,
                  onPressed: () {},
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/googlelogo.png',
                        height: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextWidget(
                        text: 'Google',
                        fontSize: 12,
                        fontFamily: 'Bold',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: 125,
                  height: 45,
                  color: Colors.blue[700],
                  onPressed: () {},
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/fblogo.png',
                        height: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextWidget(
                        text: 'Facebook',
                        fontSize: 12,
                        fontFamily: 'Bold',
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: "Don't have an account?",
                  fontSize: 12,
                  fontFamily: 'Regular',
                  color: Colors.white,
                ),
                TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    decoration: TextDecoration.underline,
                    text: 'Signup here',
                    fontSize: 14,
                    fontFamily: 'Medium',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
