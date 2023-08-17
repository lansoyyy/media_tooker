import 'package:flutter/material.dart';
import 'package:media_tooker/utils/colors.dart';

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
        child: Center(
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
            ],
          ),
        ),
      ),
    );
  }
}
