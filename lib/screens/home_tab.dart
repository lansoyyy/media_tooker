import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:media_tooker/screens/pages/freelancers/bookings_page.dart';
import 'package:media_tooker/screens/pages/messages_page.dart';
import 'package:media_tooker/screens/pages/notif_page.dart';
import 'package:media_tooker/screens/pages/profile_page.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/text_widget.dart';
import 'package:media_tooker/widgets/toast_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'home_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final box = GetStorage();

  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  String selected = '';

  Future<void> uploadPicture(
      String inputSource, String selected, bool isVideo) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = isVideo
          ? (await picker.pickVideo(
              source: inputSource == 'camera'
                  ? ImageSource.camera
                  : ImageSource.gallery,
            ))!
          : (await picker.pickImage(
              source: inputSource == 'camera'
                  ? ImageSource.camera
                  : ImageSource.gallery,
              maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Users/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Users/$fileName')
            .getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'portfolio': FieldValue.arrayUnion([
            {'img': imageURL, 'type': selected}
          ])
        });

        showToast(isVideo
            ? 'Video added to portfolio!'
            : 'Image added to portfolio!');

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    final List<Widget> children = [
      const HomeScreen(),
      const MessagesPage(),
      const NotifPage(),
      ProfilePage(id: FirebaseAuth.instance.currentUser!.uid)
    ];
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: StreamBuilder<DocumentSnapshot>(
                    stream: userData,
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      dynamic data = snapshot.data;
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (int i = 0; i < data['job'].length; i++)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    uploadPicture(
                                        'gallery',
                                        data['job'][i],
                                        data['job'][i] == 'Videographer' ||
                                            data['job'][i] == 'Editor' ||
                                            data['job'][i] ==
                                                'Cinematographer' ||
                                            data['job'][i] == 'Writer' ||
                                            data['job'][i] == 'Director');
                                  },
                                  title: Column(
                                    children: [
                                      TextWidget(
                                        text: data['job'][i],
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      Icon(
                                        Icons.add,
                                        size: 32,
                                        color: primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
              );
            },
          );
        },
      ),
      body: children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontFamily: 'QBold'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'QBold'),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped,
        currentIndex: currentIndex,
        backgroundColor: Colors.black,
        items: box.read('user') == 'Client'
            ? [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Messages',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ]
            : [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Messages',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ],
      ),
    );
  }
}
