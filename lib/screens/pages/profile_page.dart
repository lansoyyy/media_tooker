import 'package:flutter/material.dart';
import 'package:media_tooker/screens/pages/book_page.dart';
import 'package:media_tooker/screens/pages/messages_page.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/button_widget.dart';
import 'package:media_tooker/widgets/text_widget.dart';
import 'package:media_tooker/widgets/textfield_widget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    maxRadius: 75,
                    minRadius: 75,
                    backgroundImage:
                        AssetImage('assets/images/default_logo.png'),
                    child: Align(
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
                text: 'John Doe',
                fontSize: 32,
                color: primary,
                fontFamily: 'Bold',
              ),
              TextWidget(
                text: 'Cameraman',
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
                    text: 'Location: Cebu City',
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'Medium',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: 'Contact Number: 09090104355',
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'Medium',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: 'Email: johndoe@gmail.com',
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'Medium',
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MessagesPage()));
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
                    onPressed: () {},
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
              ),
              // ButtonWidget(
              //   color: primary,
              //   radius: 100,
              //   width: 50,
              //   height: 35,
              //   fontSize: 12,
              //   textColor: Colors.black,
              //   label: 'Edit Profile',
              //   onPressed: () {
              //     editProfileDialog(context);
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'My portfolio:',
                      fontSize: 18,
                      color: primary,
                      fontFamily: 'Bold',
                    ),
                  ],
                ),
              ),
              for (int i = 0; i < 2; i++)
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? 0 : 5, right: 5),
                          child: GestureDetector(
                            onTap: () {
                              portfolioDialog(context);
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
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
              ButtonWidget(
                color: primary,
                radius: 100,
                label: 'Book',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BookPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  portfolioDialog(context) {
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
