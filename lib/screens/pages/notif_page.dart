import 'package:flutter/material.dart';
import 'package:media_tooker/utils/colors.dart';

import '../../widgets/text_widget.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        title: TextWidget(
          text: 'Notifications',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.separated(
          itemCount: 20,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                maxRadius: 30,
                minRadius: 30,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              title: TextWidget(
                text: 'Name of the notification',
                fontSize: 18,
                fontFamily: 'Medium',
              ),
              subtitle: TextWidget(
                text: 'Date and Time',
                color: primary,
                fontFamily: 'Bold',
                fontSize: 12,
              ),
            );
          },
        ),
      ),
    );
  }
}
