import 'package:flutter/material.dart';
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
                    const CircleAvatar(
                      maxRadius: 30,
                      minRadius: 30,
                      backgroundImage:
                          AssetImage('assets/images/default_logo.png'),
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
                TextWidget(
                  text: 'CAMERAMAN',
                  fontSize: 14,
                  fontFamily: 'Medium',
                  color: Colors.yellow,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: index == 0 ? 0 : 5, right: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfilePage()));
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
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'EDITOR',
                  fontSize: 14,
                  fontFamily: 'Medium',
                  color: Colors.yellow,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: index == 0 ? 0 : 5, right: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfilePage()));
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
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'GRAPHIC ARTIST',
                  fontSize: 14,
                  fontFamily: 'Medium',
                  color: Colors.yellow,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: index == 0 ? 0 : 5, right: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfilePage()));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
