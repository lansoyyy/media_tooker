import 'package:flutter/material.dart';
import 'package:media_tooker/screens/home_tab.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/button_widget.dart';
import 'package:media_tooker/widgets/text_widget.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                decoration: TextDecoration.underline,
                text: 'Terms and Conditions',
                fontSize: 24,
                color: primary,
                fontFamily: 'Bold',
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextWidget(
                  text:
                      "Veniam nostrud deserunt pariatur amet irure est sint. Veniam fugiat pariatur adipisicing dolor esse elit cupidatat incididunt proident anim eu laborum magna cupidatat. Fugiat pariatur id incididunt incididunt deserunt excepteur. Esse non proident eiusmod commodo duis officia culpa. Id officia consectetur Lorem commodo ea mollit sint veniam commodo enim fugiat. Ad in reprehenderit sint anim sint eu mollit ipsum dolor sint commodo. Id quis laborum cillum occaecat quis cupidatat ullamco adipisicing aliqua qui. In veniam quis exercitation dolore. Lorem mollit duis minim nostrud commodo excepteur. Culpa dolor anim voluptate reprehenderit. Ut voluptate id et ea nisi sint Lorem labore deserunt. Do labore consectetur sit magna aliqua culpa. Lorem irure excepteur consequat ut esse ullamco aute deserunt adipisicing. Pariatur ea ullamco exercitation velit exercitation esse aliquip esse. Commodo dolor ad non qui non velit id nisi anim pariatur velit occaecat voluptate id. Nisi ut commodo sunt incididunt velit aute veniam fugiat dolor nulla irure ea. Ullamco tempor eiusmod aliqua aute consectetur velit pariatur mollit non dolore sint. Quis deserunt eiusmod fugiat qui exercitation ex minim irure mollit nostrud cupidatat esse eiusmod sit. Eiusmod qui nostrud Lorem officia consequat et. Nulla cillum enim occaecat dolore. Sit pariatur sint sunt laboris voluptate officia ea commodo. Enim nisi occaecat minim proident qui fugiat cupidatat cupidatat aute anim adipisicing. Pariatur elit tempor incididunt consequat est in proident officia. Sit et nisi eu laboris ex ipsum adipisicing eiusmod. Aute velit ipsum do culpa excepteur laboris qui culpa adipisicing. Dolore dolor do quis pariatur pariatur fugiat non dolor pariatur id fugiat culpa nisi. Velit esse ad qui occaecat culpa eiusmod quis culpa quis. Lorem irure id adipisicing nisi consequat exercitation elit. Consequat irure cillum eiusmod quis laborum do ullamco eu excepteur nulla laborum esse velit. Voluptate cillum duis anim do labore aliqua consectetur officia ut ad commodo qui non nulla.",
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonWidget(
                color: Colors.amber[800],
                radius: 100,
                label: 'I Agree',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomeTab()));
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
