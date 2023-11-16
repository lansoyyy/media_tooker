import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:media_tooker/screens/pages/freelancers/bookings_page.dart';
import 'package:media_tooker/utils/colors.dart';

import '../../widgets/text_widget.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({super.key});

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
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
      body: StreamBuilder<DocumentSnapshot>(
          stream: userData,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            dynamic data1 = snapshot.data;
            return StreamBuilder<QuerySnapshot>(
                stream: data1['type'] == 'Client'
                    ? FirebaseFirestore.instance
                        .collection('Notifs')
                        .where('userId',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .orderBy('dateTime', descending: true)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('Notifs')
                        .where('freelancerId',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .orderBy('dateTime', descending: true)
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
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.separated(
                      itemCount: data.docs.length,
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BookingsPage()));
                          },
                          leading: const CircleAvatar(
                            maxRadius: 30,
                            minRadius: 30,
                            backgroundImage:
                                AssetImage('assets/images/profile.png'),
                          ),
                          title: TextWidget(
                            text: data.docs[index]['name'],
                            fontSize: 18,
                            fontFamily: 'Medium',
                          ),
                          subtitle: TextWidget(
                            text: DateFormat.jm()
                                .format(data.docs[index]['dateTime'].toDate()),
                            color: primary,
                            fontFamily: 'Bold',
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  );
                });
          }),
    );
  }
}
