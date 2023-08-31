import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:media_tooker/services/add_user.dart';
import 'package:media_tooker/widgets/button_widget.dart';
import 'package:media_tooker/widgets/textfield_widget.dart';

import '../../utils/const.dart';
import '../../widgets/toast_widget.dart';
import '../home_screen.dart';

class AuthScreen extends StatelessWidget {
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final emailController = TextEditingController();

  final RegistrationType regType;

  final String name;
  final String address;
  final String birthday;
  final String gender;
  final String imageId;
  final String imageDocumentFile;

  AuthScreen(
      {super.key,
      required this.name,
      required this.address,
      required this.birthday,
      required this.gender,
      required this.regType,
      required this.imageId,
      required this.imageDocumentFile});

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
                    if (confirmpasswordController.text !=
                        passwordController.text) {
                      showToast('Password do not match!');
                    } else {
                      register(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  register(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // addUser(nameController.text, contactnumberController.text,
      //     addressController.text, emailController.text);

      addUser(name, address, emailController.text, regType.name, imageId,
          imageDocumentFile);

      showToast('Account created succesfully!');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        showToast('The email address is not valid.');
      } else {
        showToast(e.toString());
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
