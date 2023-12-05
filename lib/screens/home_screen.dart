import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:media_tooker/screens/pages/profile_page.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/text_widget.dart';

import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final searchController = TextEditingController();
  String nameSearched = '';

  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> children = [
    const HomeScreen(),
  ];

  List<String> dartVideographerItems = [
    "Videographer",
    "Editor",
    "Photographer",
    "Animator",
    "Graphics Designer",
    "3D Artist",
    "Cinematographer",
    "Writer",
    "Director",
    "Art Director",
    "Production Designer",
  ];

  getData(String filter) {
    return FirebaseFirestore.instance
        .collection('Users')
        .where('job', arrayContains: filter)
        .snapshots();
  }

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) => const MessagesPage()));
      //   },
      //   backgroundColor: primary,
      //   child: const Icon(
      //     Icons.message_outlined,
      //   ),
      // ),
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
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => ProfilePage(
                    //               id: FirebaseAuth.instance.currentUser!.uid,
                    //             )));
                    //   },
                    //   child: const CircleAvatar(
                    //     maxRadius: 30,
                    //     minRadius: 30,
                    //     backgroundImage:
                    //         AssetImage('assets/images/profile.png'),
                    //   ),
                    // ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Logout Confirmation',
                                    style: TextStyle(
                                        fontFamily: 'QBold',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: const Text(
                                    'Are you sure you want to Logout?',
                                    style: TextStyle(fontFamily: 'QRegular'),
                                  ),
                                  actions: <Widget>[
                                    MaterialButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () async {
                                        await FirebaseAuth.instance.signOut();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                                      },
                                      child: const Text(
                                        'Continue',
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ));
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
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
                TextWidget(
                  text: 'PRODUCTIONS',
                  fontSize: 24,
                  fontFamily: 'Bold',
                  color: primary,
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .where('type', isEqualTo: 'Production')
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
                      return Center(
                        child: data.docs.isNotEmpty
                            ? Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  for (int i = 0; i < data.docs.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage(
                                                        id: data.docs[i].id,
                                                      )));
                                        },
                                        child: CircleAvatar(
                                          maxRadius: 50,
                                          minRadius: 50,
                                          backgroundImage: NetworkImage(
                                              data.docs[i]['profilePicture']),
                                        ),
                                      ),
                                    ),
                                ],
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: TextWidget(
                                  text: 'No available',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    }),
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
                if (nameSearched != '')
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .where('job', arrayContains: nameSearched)
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

                        final sortedData =
                            List<QueryDocumentSnapshot>.from(data.docs);

                        sortedData.sort((a, b) {
                          final double priceA = a['dateTime'].toDate();
                          final double priceB = b['dateTime'].toDate();

                          return priceB.compareTo(priceA);
                        });
                        return sortedData.isNotEmpty
                            ? SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  itemCount: sortedData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: index == 0 ? 0 : 5, right: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage(
                                                        id: sortedData[index]
                                                            .id,
                                                      )));
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: CircleAvatar(
                                                    maxRadius: 25,
                                                    minRadius: 25,
                                                    backgroundImage:
                                                        NetworkImage(sortedData[
                                                                index]
                                                            ['profilePicture']),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextWidget(
                                                  text: sortedData[index]
                                                      ['name'],
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
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  child: TextWidget(
                                    text: 'No available',
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                      }),
                if (nameSearched == '')
                  for (int i = 0; i < dartVideographerItems.length; i++)
                    Column(
                      children: [
                        types(
                            dartVideographerItems[i], dartVideographerItems[i]),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
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
            stream: getData(filter),
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

              final sortedData = List<QueryDocumentSnapshot>.from(data.docs);

              return sortedData.isNotEmpty
                  ? SizedBox(
                      height: 120,
                      child: ListView.builder(
                        itemCount: sortedData.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: index == 0 ? 0 : 5, right: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                          id: sortedData[index].id,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: CircleAvatar(
                                          maxRadius: 25,
                                          minRadius: 25,
                                          backgroundImage: NetworkImage(
                                              sortedData[index]
                                                  ['profilePicture']),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                        text: sortedData[index]['name'],
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
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: TextWidget(
                          text: 'No available',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    );
            }),
      ],
    );
  }
}
