import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:media_tooker/screens/pages/chat_page.dart';
import 'package:media_tooker/widgets/text_widget.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final searchController = TextEditingController();

  String nameSearched = '';

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        title: TextWidget(
          text: 'Messages',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'Regular', fontSize: 14),
                  onChanged: (value) {
                    setState(() {
                      nameSearched = value;
                    });
                  },
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(fontFamily: 'QRegular'),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      )),
                  controller: searchController,
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: box.read('user')  == 'Client' ? FirebaseFirestore.instance
                  .collection('Messages')
                  .where('userId',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                
                  .snapshots() :  FirebaseFirestore.instance
                  .collection('Messages')
                  .where('freelancerId',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                
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
                print(data.docs.length);
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: data.docs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                        userData:  box.read('user')  == 'Client' ? data.docs[index]
                                            ['freelancerId'] :  data.docs[index]
                                            ['userId'],
                                      )));
                            },
                            child: CircleAvatar(
                              maxRadius: 35,
                              minRadius: 35,
                              backgroundImage: NetworkImage(
                              box.read('user')  == 'Client' ?     data.docs[index]['freelancerProfile'] : data.docs[index]['userProfile']),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.white,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: box.read('user')  == 'Client' ? FirebaseFirestore.instance
                  .collection('Messages')
                  .where('userId',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .orderBy('dateTime', descending: true)
                  .snapshots() :  FirebaseFirestore.instance
                  .collection('Messages')
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
                return Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        List msg = data.docs[index]['messages'];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                         userData:  box.read('user')  == 'Client' ? data.docs[index]
                                            ['freelancerId'] :  data.docs[index]
                                            ['userId'],
                                      )));
                            },
                            leading: CircleAvatar(
                              maxRadius: 40,
                              minRadius: 40,
                              backgroundImage: NetworkImage(
                                 box.read('user')  == 'Client' ? data.docs[index]['freelancerProfile'] :  data.docs[index]['userProfile']),
                              child: const Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            title: TextWidget(
                              text:  box.read('user')  == 'Client' ?data.docs[index]['freelancerName'] : data.docs[index]['userName'],
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: 'Bold',
                            ),
                            subtitle: TextWidget(
                              text: msg[msg.length - 1]['message'],
                              fontSize: 14,
                              color: Colors.grey,
                              fontFamily: 'Regular',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              })
        ],
      )),
    );
  }
}
