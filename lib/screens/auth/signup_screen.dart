import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String job = '';

  int _dropValue1 = 0;
  int _dropValue2 = 0;

  List jobList = ['Cameraman', 'Graphic Artist', 'Editor', 'Others'];
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

  final contactnumberController = TextEditingController();

  List genders = ['Male', 'Female', 'Others'];

  String gender = 'Male';

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
              TextFieldWidget(
                  label: 'City and Zip Code', controller: addressController),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                  inputType: TextInputType.number,
                  label: 'Contact Number',
                  controller: contactnumberController),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Birthday',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Bold',
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: '*',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Bold',
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      dateFromPicker(context);
                    },
                    child: SizedBox(
                      width: 325,
                      height: 50,
                      child: TextFormField(
                        enabled: false,
                        style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: primary,
                        ),

                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.calendar_month_outlined,
                            color: primary,
                          ),
                          hintStyle: const TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          hintText: dateController.text,
                          border: InputBorder.none,
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          errorStyle:
                              const TextStyle(fontFamily: 'Bold', fontSize: 12),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),

                        controller: dateController,
                        // Pass the validator to the TextFormField
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextWidget(
                        text: 'Gender:', fontSize: 14, color: primary),
                  ),
                  Container(
                    width: 325,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: DropdownButton(
                          dropdownColor: Colors.white,
                          focusColor: Colors.white,
                          value: _dropValue2,
                          items: [
                            for (int i = 0; i < genders.length; i++)
                              DropdownMenuItem(
                                onTap: (() {
                                  gender = genders[i];
                                }),
                                value: i,
                                child: Row(
                                  children: [
                                    TextWidget(
                                        text: '${genders[i]}',
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                          ],
                          onChanged: ((value) {
                            setState(() {
                              _dropValue2 = int.parse(value.toString());
                            });
                          })),
                    ),
                  ),
                ],
              ),
              widget.regType == RegistrationType.Independent
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: TextWidget(
                              text: 'Job Type:',
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Container(
                          width: 325,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: DropdownButton(
                                dropdownColor: Colors.white,
                                focusColor: Colors.white,
                                value: _dropValue1,
                                items: [
                                  for (int i = 0; i < jobList.length; i++)
                                    DropdownMenuItem(
                                      onTap: (() {
                                        job = jobList[i];
                                      }),
                                      value: i,
                                      child: Row(
                                        children: [
                                          TextWidget(
                                              text: 'Service: ${jobList[i]}',
                                              fontSize: 14,
                                              color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                ],
                                onChanged: ((value) {
                                  setState(() {
                                    _dropValue1 = int.parse(value.toString());
                                  });
                                })),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
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
                            contactnumber: contactnumberController.text,
                            job: job,
                            imageDocumentFile: docImageURL,
                            imageId: idImageURL,
                            regType: widget.regType,
                            address: addressController.text,
                            birthday: dateController.text,
                            gender: gender,
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

  final dateController = TextEditingController();

  void dateFromPicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: primary!,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(() {
        dateController.text = formattedDate;
      });
    } else {
      return null;
    }
  }
}
