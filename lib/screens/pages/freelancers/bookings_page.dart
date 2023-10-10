import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:media_tooker/screens/pages/freelancers/task_page.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/button_widget.dart';
import 'package:media_tooker/widgets/text_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../services/add_notif.dart';
import '../../../widgets/toast_widget.dart';

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
        backgroundColor: Colors.black,
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
            backgroundColor: Colors.black,
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
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Bookings')
                              // .where('freelancerId',
                              //     isEqualTo:
                              //         FirebaseAuth.instance.currentUser!.uid)
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
                                  color: Colors.white,
                                )),
                              );
                            }

                            final data = snapshot.requireData;
                            return Expanded(
                              child: SizedBox(
                                child: ListView.builder(
                                  itemCount: data.docs.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          width: double.infinity,
                                          height: 200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextWidget(
                                                          text: 'OCT',
                                                          fontSize: 24,
                                                          fontFamily: 'Medium',
                                                          color: primary,
                                                        ),
                                                        TextWidget(
                                                          text: '14',
                                                          fontSize: 48,
                                                          fontFamily: 'Bold',
                                                          color: primary,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextWidget(
                                                          text: 'John Doe',
                                                          fontSize: 18,
                                                          fontFamily: 'Bold',
                                                          color: primary,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextWidget(
                                                          text: 'Task: Dota',
                                                          fontSize: 12,
                                                          fontFamily: 'Regular',
                                                          color: primary,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextWidget(
                                                          text: 'Time: 9:30AM',
                                                          fontSize: 12,
                                                          fontFamily: 'Regular',
                                                          color: primary,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextWidget(
                                                          text: 'Note: 9:30AM',
                                                          fontSize: 12,
                                                          fontFamily: 'Regular',
                                                          color: primary,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ButtonWidget(
                                                      color: Colors.black,
                                                      height: 35,
                                                      width: 75,
                                                      label: 'Accept',
                                                      onPressed: () async {
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

                                                        addNotifFreelancer(
                                                            'Your booking was accepted: ${data.docs[index]['name']}',
                                                            data.docs[index]
                                                                ['myId']);

                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    ButtonWidget(
                                                      color: Colors.black,
                                                      height: 35,
                                                      width: 75,
                                                      label: 'Decline',
                                                      onPressed: () async {
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

                                                        addNotifFreelancer(
                                                            'Your booking was rejected: ${data.docs[index]['name']}',
                                                            data.docs[index]
                                                                ['myId']);

                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                    // return ListTile(
                                    //   title: TextWidget(
                                    //     text: data.docs[index]['name'],
                                    //     fontSize: 18,
                                    //     fontFamily: 'Bold',
                                    //     color: Colors.white,
                                    //   ),
                                    //   subtitle: TextWidget(
                                    //     text: data.docs[index]['note'],
                                    //     fontSize: 12,
                                    //     fontFamily: 'Regular',
                                    //     color: Colors.white,
                                    //   ),
                                    //   trailing: data.docs[index]['status'] ==
                                    //           'Pending'
                                    //       ? SizedBox(
                                    //           width: 150,
                                    //           child: Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .spaceEvenly,
                                    //             children: [
                                    //               GestureDetector(
                                    //                 onTap: () async {
                                    //                   await FirebaseFirestore
                                    //                       .instance
                                    //                       .collection(
                                    //                           'Bookings')
                                    //                       .doc(data
                                    //                           .docs[index].id)
                                    //                       .update({
                                    //                     'status': 'Rejected',
                                    //                   });
                                    //                   showToast(
                                    //                       'Succesfully rejected booking!');

                                    //                   addNotifFreelancer(
                                    //                       'Your booking was rejected: ${data.docs[index]['name']}',
                                    //                       data.docs[index]
                                    //                           ['myId']);
                                    //                 },
                                    //                 child: const Icon(
                                    //                   Icons.remove_circle,
                                    //                 ),
                                    //               ),
                                    //               GestureDetector(
                                    //                 onTap: () async {
                                    //                   await FirebaseFirestore
                                    //                       .instance
                                    //                       .collection(
                                    //                           'Bookings')
                                    //                       .doc(data
                                    //                           .docs[index].id)
                                    //                       .update({
                                    //                     'status': 'Accepted',
                                    //                   });
                                    //                   showToast(
                                    //                       'Succesfully Accepted booking!');

                                    //                   addNotifFreelancer(
                                    //                       'Your booking was accepted: ${data.docs[index]['name']}',
                                    //                       data.docs[index]
                                    //                           ['myId']);
                                    //                 },
                                    //                 child: const Icon(
                                    //                   Icons.add_circle_rounded,
                                    //                   color: Colors.white,
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         )
                                    //       : const SizedBox(),
                                    // );
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
