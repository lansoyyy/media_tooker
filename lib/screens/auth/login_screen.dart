import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:media_tooker/screens/auth/signup_selection_screen.dart';
import 'package:media_tooker/screens/home_screen.dart';
import 'package:media_tooker/screens/pages/freelancers/bookings_page.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/button_widget.dart';
import 'package:media_tooker/widgets/text_widget.dart';
import 'package:media_tooker/widgets/textfield_widget.dart';

import '../../widgets/toast_widget.dart';

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
              onPressed: () {
                login(context);
              },
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BookingsPage()));
                  },
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignupSelectionScreen()));
                  },
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

  login(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      showToast('Logged in succesfully!');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast("No user found with that email.");
      } else if (e.code == 'wrong-password') {
        showToast("Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        showToast("Invalid email provided.");
      } else if (e.code == 'user-disabled') {
        showToast("User account has been disabled.");
      } else {
        showToast("An error occurred: ${e.message}");
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
