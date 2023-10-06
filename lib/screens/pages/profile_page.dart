import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:media_tooker/screens/pages/book_page.dart';
import 'package:media_tooker/screens/pages/chat_page.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/button_widget.dart';
import 'package:media_tooker/widgets/text_widget.dart';
import 'package:media_tooker/widgets/textfield_widget.dart';
import 'package:media_tooker/widgets/toast_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'freelancers/bookings_page.dart';

class ProfilePage extends StatefulWidget {
  String id;

  ProfilePage({super.key, required this.id});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  Future<void> uploadPicture(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
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
          'portfolio': FieldValue.arrayUnion([imageURL])
        });

        showToast('Image added to portfolio!');

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

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.id)
        .snapshots();
    return Scaffold(
      floatingActionButton: FirebaseAuth.instance.currentUser!.uid == widget.id
          ? FloatingActionButton(
              backgroundColor: primary,
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {
                uploadPicture('gallery');
              })
          : const SizedBox(),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          maxRadius: 75,
                          minRadius: 75,
                          backgroundImage: NetworkImage(data['profilePicture']),
                          child: const Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.circle,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                      text: data['name'],
                      fontSize: 32,
                      color: primary,
                      fontFamily: 'Bold',
                    ),
                    TextWidget(
                      text: data['job'],
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Medium',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Location: ${data['address']}',
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Medium',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          text: 'Contact Number: ${data['contactNumber']}',
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Medium',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          text: 'Email: ${data['email']}',
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Medium',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FirebaseAuth.instance.currentUser!.uid != data.id
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                            userData: data.id,
                                          )));
                                },
                                icon: const Icon(
                                  Icons.message,
                                  color: Colors.white,
                                ),
                                label: TextWidget(
                                  text: 'Message',
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton.icon(
                                onPressed: () async {
                                  var text = 'tel:${data['contactNumber']}';
                                  if (await canLaunch(text)) {
                                    await launch(text);
                                  }
                                },
                                icon: const Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                label: TextWidget(
                                  text: 'Call',
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonWidget(
                                color: primary,
                                radius: 100,
                                width: 50,
                                height: 35,
                                fontSize: 12,
                                textColor: Colors.black,
                                label: 'Edit Profile',
                                onPressed: () {
                                  editProfileDialog(context);
                                },
                              ),
                              SizedBox(
                                width: data['type'] != 'Client' ? 20 : 0,
                              ),
                              data['type'] != 'Client'
                                  ? ButtonWidget(
                                      color: primary,
                                      radius: 100,
                                      width: 50,
                                      height: 35,
                                      fontSize: 12,
                                      textColor: Colors.black,
                                      label: 'View Bookings',
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const BookingsPage()));
                                      },
                                    )
                                  : const SizedBox()
                            ],
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: FirebaseAuth.instance.currentUser!.uid !=
                                    data.id
                                ? 'Portfolio'
                                : 'My portfolio:',
                            fontSize: 18,
                            color: primary,
                            fontFamily: 'Bold',
                          ),
                        ],
                      ),
                    ),
                    for (int i = 0; i < 2; i++)
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: data['portfolio'].length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: index == 0 ? 0 : 5, right: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    portfolioDialog(
                                        context, data['portfolio'][index]);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            data['portfolio'][index],
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    FirebaseAuth.instance.currentUser!.uid != data.id
                        ? ButtonWidget(
                            color: primary,
                            radius: 100,
                            label: 'Book',
                            onPressed: () {
                              box.write('name', data['name']);
                              box.write('job', data['job']);
                              box.write('id', data.id);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const BookPage()));
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          }),
    );
  }

  portfolioDialog(context, String image) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(
                          image,
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final contactController = TextEditingController();

  final emailController = TextEditingController();

  editProfileDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: primary,
                      ),
                    ),
                  ),
                  TextFieldWidget(
                    label: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFieldWidget(
                    label: 'Location',
                    controller: addressController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFieldWidget(
                    label: 'Contact',
                    controller: contactController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFieldWidget(
                    label: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    color: primary,
                    radius: 100,
                    width: 150,
                    height: 45,
                    fontSize: 15,
                    textColor: Colors.black,
                    label: 'Save',
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(widget.id)
                          .update({
                        'name': nameController.text,
                        'address': addressController.text,
                        'contactNumber': contactController.text,
                        'email': emailController.text
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
