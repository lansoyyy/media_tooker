import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:media_tooker/services/add_messages.dart';
import 'package:media_tooker/utils/colors.dart';

import '../../widgets/text_widget.dart';

class ChatPage extends StatefulWidget {
  String? userData;

  ChatPage({
    super.key,
    this.userData,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final msgController = TextEditingController();

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.userData)
        .snapshots();

    final Stream<DocumentSnapshot> userData1 = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    final Stream<DocumentSnapshot> chatData = box.read('user') == 'Client' ?  FirebaseFirestore.instance
        .collection('Messages')
        .doc( FirebaseAuth.instance.currentUser!.uid + widget.userData!)
        .snapshots() : FirebaseFirestore.instance
        .collection('Messages')
        .doc(widget.userData! + FirebaseAuth.instance.currentUser!.uid)
        .snapshots()  ;
    return Scaffold(
      backgroundColor: Colors.black,
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
            dynamic data = snapshot.data;
            return SafeArea(
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
                            leading: CircleAvatar(
                              maxRadius: 25,
                              minRadius: 25,
                              backgroundImage:
                                  NetworkImage(data['profilePicture']),
                              child: const Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            title: TextWidget(
                              text: data['name'],
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
                  StreamBuilder<DocumentSnapshot>(
                      stream: chatData,
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: Text('Loading'));
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child:
                                  SizedBox(child: CircularProgressIndicator()));
                        }

                        try {
                          dynamic data = snapshot.data;
                          List messages = data['messages'] ?? [];
                          return Expanded(
                            child: SizedBox(
                              child: ListView.builder(
                                  itemCount:
                                      messages.isNotEmpty ? messages.length : 0,
                                  itemBuilder: ((context, index) {
                                    return Row(
                                      mainAxisAlignment: messages[index]
                                                  ['sender'] ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        messages[index]['sender'] !=
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: CircleAvatar(
                                                  minRadius: 15,
                                                  maxRadius: 15,
                                                  backgroundImage: box.read('user') == 'Client' ?  NetworkImage(
                                                      data['freelancerProfile']) :   NetworkImage(
                                                      data['userProfile']),
                                                ),
                                              )
                                            : const SizedBox(),
                                        Column(
                                          crossAxisAlignment: messages[index]
                                                      ['sender'] ==
                                                  FirebaseAuth
                                                      .instance.currentUser!.uid
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 15.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      const Radius.circular(
                                                          20.0),
                                                  topRight:
                                                      const Radius.circular(
                                                          20.0),
                                                  bottomLeft: messages[index]
                                                              ['sender'] ==
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid
                                                      ? const Radius.circular(
                                                          20.0)
                                                      : const Radius.circular(
                                                          0.0),
                                                  bottomRight: messages[index]
                                                              ['sender'] ==
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid
                                                      ? const Radius.circular(
                                                          0.0)
                                                      : const Radius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              child: Text(
                                                messages[index]['message'],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0,
                                                    fontFamily: 'QRegular'),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                DateFormat.jm().format(
                                                    messages[index]['dateTime']
                                                        .toDate()),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0,
                                                    fontFamily: 'QRegular'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        messages[index]['sender'] ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: CircleAvatar(
                                                  minRadius: 15,
                                                  maxRadius: 15,
                                                  backgroundImage: NetworkImage(
                                                    data['userProfile'],
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    );
                                  })),
                            ),
                          );
                        } catch (e) {
                          return const Expanded(child: SizedBox());
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: msgController,
                      decoration: InputDecoration(
                          suffixIcon: StreamBuilder<DocumentSnapshot>(
                              stream: userData1,
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const SizedBox();
                                } else if (snapshot.hasError) {
                                  return const Center(
                                      child: Text('Something went wrong'));
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                }
                                dynamic myData = snapshot.data;
                                return IconButton(
                                  onPressed: () async {

                                    print(box.read('user'));
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('Messages')
                                          .doc( box.read('user') == 'Client' ? FirebaseAuth
                                                  .instance.currentUser!.uid +
                                              widget.userData! :  
                                              widget.userData! + FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .update({
                                        'lastId': FirebaseAuth
                                            .instance.currentUser!.uid,
                                        'lastMessage': msgController.text,
                                        'dateTime': DateTime.now(),
                                        'seen': false,
                                        'messages': FieldValue.arrayUnion([
                                          {
                                            'message': msgController.text,
                                            'dateTime': DateTime.now(),
                                            'sender': FirebaseAuth
                                                .instance.currentUser!.uid
                                          },
                                        ]),
                                      });
                                    } catch (e) {
                                      addMessage(
                                          widget.userData,
                                          msgController.text,
                                          data['name'],
                                          myData['name'],
                                          data['profilePicture'],
                                          myData['profilePicture']);
                                    }

                                    msgController.clear();
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: primary,
                                  ),
                                );
                              }),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
