import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:media_tooker/screens/pages/freelancers/task_page.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/text_widget.dart';
import 'package:media_tooker/widgets/toast_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  final tasknameController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final noteController = TextEditingController();
  final labelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const TaskPage()));
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: 'Bookings',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: TableCalendar(
        onDaySelected: (selectedDay, focusedDay) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Scheduled Bookings',
                        fontSize: 14,
                        fontFamily: 'Bold',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Bookings')
                              .where('freelancerId',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .where('date',
                                  isEqualTo: DateFormat('yyyy-M-dd')
                                      .format(selectedDay)
                                      .toString())
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('error');
                              return const Center(child: Text('Error'));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.black,
                                )),
                              );
                            }

                            final data = snapshot.requireData;
                            return Expanded(
                              child: SizedBox(
                                child: ListView.builder(
                                  itemCount: data.docs.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: TextWidget(
                                        text: data.docs[index]['name'],
                                        fontSize: 18,
                                        fontFamily: 'Bold',
                                      ),
                                      subtitle: TextWidget(
                                        text: data.docs[index]['note'],
                                        fontSize: 12,
                                        fontFamily: 'Regular',
                                      ),
                                      trailing: data.docs[index]['status'] ==
                                              'Pending'
                                          ? SizedBox(
                                              width: 150,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Bookings')
                                                          .doc(data
                                                              .docs[index].id)
                                                          .update({
                                                        'status': 'Rejected',
                                                      });
                                                      showToast(
                                                          'Succesfully rejected booking!');
                                                    },
                                                    child: const Icon(
                                                      Icons.remove_circle,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Bookings')
                                                          .doc(data
                                                              .docs[index].id)
                                                          .update({
                                                        'status': 'Accepted',
                                                      });
                                                      showToast(
                                                          'Succesfully Accepted booking!');
                                                    },
                                                    child: const Icon(
                                                      Icons.add_circle_rounded,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const SizedBox(),
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              );
            },
          );
        },
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
      ),
    );
  }
}
