import 'package:flutter/material.dart';
import 'package:media_tooker/screens/auth/signup_screen.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/text_widget.dart';

import '../../utils/const.dart';
import '../../widgets/button_widget.dart';

class ProviderSelectionScreen extends StatelessWidget {
  const ProviderSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'Service Provider:',
              fontSize: 24,
              color: primary,
              fontFamily: 'Regular',
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
              radius: 100,
              color: Colors.amber[800],
              label: 'Production',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignupScreen(
                          regType: RegistrationType.Production,
                        )));
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
              radius: 100,
              color: Colors.amber[800],
              label: 'Independent',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignupScreen(
                          regType: RegistrationType.Independent,
                        )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
