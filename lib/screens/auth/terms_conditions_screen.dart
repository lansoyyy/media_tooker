import 'package:flutter/material.dart';
import 'package:media_tooker/screens/auth/provider_selection_screen.dart';
import 'package:media_tooker/screens/auth/signup_screen.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/text_widget.dart';

import '../../widgets/button_widget.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidget(
              text: 'Terms and Conditions',
              fontSize: 24,
              color: primary,
              fontFamily: 'Regular',
            ),
            ButtonWidget(
              radius: 100,
              color: Colors.amber[800],
              label: 'Service Provider',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProviderSelectionScreen()));
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
              radius: 100,
              color: Colors.amber[800],
              label: 'Client',
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
