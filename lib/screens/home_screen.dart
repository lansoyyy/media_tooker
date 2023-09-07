import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:media_tooker/screens/pages/messages_page.dart';
import 'package:media_tooker/screens/pages/profile_page.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  String nameSearched = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MessagesPage()));
        },
        backgroundColor: primary,
        child: const Icon(
          Icons.message_outlined,
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'mediaTooker',
                      fontSize: 32,
                      fontFamily: 'Bold',
                      color: primary,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                  id: FirebaseAuth.instance.currentUser!.uid,
                                )));
                      },
                      child: const CircleAvatar(
                        maxRadius: 30,
                        minRadius: 30,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
                          color: Colors.white,
                          fontFamily: 'Regular',
                          fontSize: 14),
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
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextWidget(
                    text: 'LOCATION',
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'PRODUCTIONS',
                  fontSize: 24,
                  fontFamily: 'Bold',
                  color: primary,
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      for (int i = 0; i < 6; i++)
                        const Padding(
                          padding: EdgeInsets.all(5),
                          child: CircleAvatar(
                            maxRadius: 50,
                            minRadius: 50,
                            backgroundImage:
                                AssetImage('assets/images/default_logo.png'),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'INDEPENDENT',
                  fontSize: 24,
                  fontFamily: 'Bold',
                  color: primary,
                ),
                const SizedBox(
                  height: 10,
                ),
                types('CAMERAMAN', 'Cameraman'),
                const SizedBox(
                  height: 10,
                ),
                types('EDITOR', 'Editor'),
                const SizedBox(
                  height: 10,
                ),
                types('GRAPHIC ARTIST', 'Graphic Artist'),
                const SizedBox(
                  height: 10,
                ),
                types('OTHERS', 'Others'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget types(title, filter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: title,
          fontSize: 14,
          fontFamily: 'Medium',
          color: Colors.yellow,
        ),
        const SizedBox(
          height: 5,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .where('job', isEqualTo: filter)
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
              return SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: data.docs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.only(left: index == 0 ? 0 : 5, right: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                    id: data.docs[index].id,
                                  )));
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 60,
                                  ),
                                ),
                                TextWidget(
                                  text: data.docs[index]['name'],
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
      ],
    );
  }
}
