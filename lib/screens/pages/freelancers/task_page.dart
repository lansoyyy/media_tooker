import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: DateFormat('MM/dd/yyyy')
                            .format(DateTime.now())
                            .toString(),
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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Bookings')
                      .where('date',
                          isEqualTo: DateFormat('yyyy-M-dd')
                              .format(DateTime.now())
                              .toString())
                      .where('freelancerId',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where('status', isEqualTo: 'Accepted')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    return Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                          itemCount: data.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                leading: data.docs[index]['isCompleted'] == true
                                    ? GestureDetector(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Bookings')
                                              .doc(data.docs[index].id)
                                              .update({
                                            'isCompleted': false,
                                          });
                                        },
                                        child: Icon(
                                          Icons.check_box,
                                          color: primary,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Bookings')
                                              .doc(data.docs[index].id)
                                              .update({
                                            'isCompleted': true,
                                          });
                                        },
                                        child: Icon(
                                          Icons
                                              .check_box_outline_blank_outlined,
                                          color: primary,
                                        ),
                                      ),
                                tileColor: Colors.white,
                                title: TextWidget(
                                  text: data.docs[index]['name'],
                                  fontSize: 14,
                                  fontFamily: 'Bold',
                                  color: primary,
                                ),
                                subtitle: TextWidget(
                                  text: data.docs[index]['note'],
                                  fontSize: 12,
                                  fontFamily: 'Regular',
                                  color: Colors.grey,
                                ),
                                trailing: TextWidget(
                                  text: '${data.docs[index]['time']}',
                                  fontSize: 12,
                                  fontFamily: 'Regular',
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
