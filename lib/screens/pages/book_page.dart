import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:media_tooker/screens/pages/add_booking_page.dart';
import 'package:media_tooker/widgets/text_widget.dart';

import '../../utils/colors.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final cont = EventController();
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Bookings')
              .where('myId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('error');
              return const Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                )),
              );
            }

            final data = snapshot.requireData;

            for (int i = 0; i < data.docs.length; i++) {
              cont.add(CalendarEventData(
                  event: data.docs[i]['name'],
                  startTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day, DateTime.now().hour),
                  endTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day, DateTime.now().hour + 2),
                  title: data.docs[i]['name'],
                  date: DateTime.parse(data.docs[i]['date'].toString())));
            }
            return WeekView(
              controller: cont,
              eventTileBuilder: (date, events, boundry, start, end) {
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
                          text: events[0].title,
                          fontSize: 10,
                          color: Colors.white),
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
            );
          }),
    );
  }
}
