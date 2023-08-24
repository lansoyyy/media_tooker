import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:media_tooker/screens/pages/add_booking_page.dart';
import 'package:media_tooker/widgets/text_widget.dart';

import '../../utils/colors.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddBookingPage()));
        },
      ),
      body: WeekView(
        eventTileBuilder: (date, events, boundry, start, end) {
          // Return your widget to display as event tile.
          return Padding(
            padding: const EdgeInsets.all(2.5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.5),
                child: TextWidget(
                    text: events[0].title, fontSize: 10, color: Colors.white),
              ),
            ),
          );
        },
        initialDay: DateTime.now(),
        headerStyle: HeaderStyle(
            headerTextStyle: const TextStyle(
              fontFamily: 'QRegular',
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: BoxDecoration(
              color: primary!,
            )),
      ),
    );
  }
}
