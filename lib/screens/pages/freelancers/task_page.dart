import 'package:flutter/material.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/text_widget.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'July 28, 2023',
                        fontSize: 14,
                        fontFamily: 'Regular',
                        color: Colors.white,
                      ),
                      TextWidget(
                        text: 'TODAY',
                        fontSize: 14,
                        fontFamily: 'Bold',
                        color: primary,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.check_box,
                            color: primary,
                          ),
                          tileColor: Colors.white,
                          title: TextWidget(
                            text: 'Title here',
                            fontSize: 14,
                            fontFamily: 'Bold',
                            color: primary,
                          ),
                          subtitle: TextWidget(
                            text: 'Description here',
                            fontSize: 12,
                            fontFamily: 'Regular',
                            color: Colors.grey,
                          ),
                          trailing: TextWidget(
                            text: '10:30',
                            fontSize: 12,
                            fontFamily: 'Regular',
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
