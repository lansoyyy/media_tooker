import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:media_tooker/screens/auth/signup_selection_screen.dart';
import 'package:media_tooker/screens/home_screen.dart';
import 'package:media_tooker/services/add_user.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/button_widget.dart';
import 'package:media_tooker/widgets/text_widget.dart';
import 'package:media_tooker/widgets/textfield_widget.dart';

import '../../widgets/toast_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void logInWithGoogle(context) async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();

      final googleSignInAuth = await googleSignInAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Access the user's display name (username)
      final user = authResult.user;
      // addUser(googleSignInAuth, address, email, type, id, doc, job, contactNumber)

      addUser(user!.displayName, '', user.email, 'Client', user.uid, '', '',
          user.phoneNumber);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: ((context) {
                          final formKey = GlobalKey<FormState>();
                          final TextEditingController emailController =
                              TextEditingController();

                          return AlertDialog(
                            title: TextWidget(
                              text: 'Forgot Password',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            content: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFieldWidget(
                                    hint: 'Email',
                                    textCapitalization: TextCapitalization.none,
                                    inputType: TextInputType.emailAddress,
                                    label: 'Email',
                                    controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an email address';
                                      }
                                      final emailRegex = RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                      if (!emailRegex.hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: (() {
                                  Navigator.pop(context);
                                }),
                                child: TextWidget(
                                  text: 'Cancel',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: (() async {
                                  if (formKey.currentState!.validate()) {
                                    try {
                                      Navigator.pop(context);
                                      await FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                              email: emailController.text);
                                      showToast(
                                          'Password reset link sent to ${emailController.text}');
                                    } catch (e) {
                                      String errorMessage = '';

                                      if (e is FirebaseException) {
                                        switch (e.code) {
                                          case 'invalid-email':
                                            errorMessage =
                                                'The email address is invalid.';
                                            break;
                                          case 'user-not-found':
                                            errorMessage =
                                                'The user associated with the email address is not found.';
                                            break;
                                          default:
                                            errorMessage =
                                                'An error occurred while resetting the password.';
                                        }
                                      } else {
                                        errorMessage =
                                            'An error occurred while resetting the password.';
                                      }

                                      showToast(errorMessage);
                                      Navigator.pop(context);
                                    }
                                  }
                                }),
                                child: TextWidget(
                                  text: 'Continue',
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          );
                        }),
                      );
                    },
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
                    onPressed: () {
                      logInWithGoogle(context);
                    },
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
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const BookingsPage()));
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
      ),
    );
  }

  bool isVerified = false;

  login(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      await FirebaseFirestore.instance
          .collection('Users')
          .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((QuerySnapshot querySnapshot) async {
        for (var doc in querySnapshot.docs) {
          if (doc['isVerified']) {
            showToast('Logged in succesfully!');
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else {
            showToast('Account not yet verified!');
            await FirebaseAuth.instance.signOut();
          }
        }
      });
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
