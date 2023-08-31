import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:media_tooker/screens/auth/auth_signup_screen.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/utils/const.dart';
import 'package:media_tooker/widgets/button_widget.dart';
import 'package:media_tooker/widgets/textfield_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import '../../widgets/text_widget.dart';

class SignupScreen extends StatefulWidget {
  final RegistrationType regType;

  const SignupScreen({super.key, required this.regType});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Future<void> uploadDocumentFile(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      idFileName = path.basename(pickedImage.path);
      idImageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: const [
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
            .ref('ID/$idFileName')
            .putFile(idImageFile);
        idImageURL = await firebase_storage.FirebaseStorage.instance
            .ref('ID/$idFileName')
            .getDownloadURL();

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

  late String docFileName = '';

  late File docImageFile;

  late String docImageURL = '';

  late String idFileName = '';

  late File idImageFile;

  late String idImageURL = '';

  Future<void> uploadValidID(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      docFileName = path.basename(pickedImage.path);
      docImageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: const [
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
            .ref('Document/$docFileName')
            .putFile(docImageFile);
        docImageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Document/$docFileName')
            .getDownloadURL();

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

  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final birthdayController = TextEditingController();

  final genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    text: "Register as a:",
                    fontSize: 14,
                    fontFamily: 'Regular',
                    color: Colors.white,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: TextWidget(
                      text: widget.regType.name,
                      fontSize: 18,
                      fontFamily: 'Bold',
                      color: primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(label: 'Name', controller: nameController),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(label: 'Address', controller: addressController),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                  label: 'Birthday', controller: birthdayController),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(label: 'Gender', controller: genderController),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Valid ID:',
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Bold',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    idImageURL == ''
                        ? GestureDetector(
                            onTap: () {
                              uploadValidID('gallery');
                            },
                            child: Container(
                              height: 125,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_circle_outline_outlined,
                                  size: 58,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              uploadValidID('gallery');
                            },
                            child: Container(
                              height: 125,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(idImageURL),
                                      fit: BoxFit.cover)),
                              child: const Center(
                                child: Icon(
                                  Icons.add_circle_outline_outlined,
                                  size: 58,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Legal Document:',
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Bold',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    docImageURL == ''
                        ? GestureDetector(
                            onTap: () {
                              uploadDocumentFile('gallery');
                            },
                            child: Container(
                              height: 125,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_circle_outline_outlined,
                                  size: 58,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              uploadDocumentFile('gallery');
                            },
                            child: Container(
                              height: 125,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(docImageURL),
                                      fit: BoxFit.cover)),
                              child: const Center(
                                child: Icon(
                                  Icons.add_circle_outline_outlined,
                                  size: 58,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonWidget(
                color: Colors.amber[800],
                radius: 100,
                label: 'Done',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AuthScreen(
                            imageDocumentFile: docImageURL,
                            imageId: idImageURL,
                            regType: widget.regType,
                            address: addressController.text,
                            birthday: birthdayController.text,
                            gender: genderController.text,
                            name: nameController.text,
                          )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
