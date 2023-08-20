import 'package:flutter/material.dart';
import 'package:media_tooker/utils/colors.dart';

import '../../widgets/text_widget.dart';

class ChatPage extends StatelessWidget {
  final msgController = TextEditingController();

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: primary,
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: ListTile(
                      leading: const CircleAvatar(
                        maxRadius: 25,
                        minRadius: 25,
                        backgroundImage:
                            AssetImage('assets/images/default_logo.png'),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.circle,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      title: TextWidget(
                        text: 'John Doe',
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Bold',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: SizedBox(
                height: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: msgController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        msgController.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: primary,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
