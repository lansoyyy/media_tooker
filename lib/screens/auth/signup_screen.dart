import 'package:flutter/material.dart';
import 'package:media_tooker/screens/auth/auth_signup_screen.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/button_widget.dart';
import 'package:media_tooker/widgets/textfield_widget.dart';

import '../../widgets/text_widget.dart';

class SignupScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final birthdayController = TextEditingController();
  final genderController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    text: "Register as a:",
                    fontSize: 14,
                    fontFamily: 'Regular',
                    color: Colors.white,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: TextWidget(
                      text: 'Production',
                      fontSize: 18,
                      fontFamily: 'Bold',
                      color: primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(label: 'Name', controller: nameController),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(label: 'Address', controller: addressController),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                  label: 'Email Address', controller: emailController),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                  label: 'Birthday', controller: birthdayController),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(label: 'Gender', controller: genderController),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Valid ID:',
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Bold',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 125,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add_circle_outline_outlined,
                          size: 58,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Legal Document:',
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Bold',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 125,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add_circle_outline_outlined,
                          size: 58,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonWidget(
                color: Colors.amber[800],
                radius: 100,
                label: 'Done',
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AuthScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
