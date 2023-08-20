import 'package:flutter/material.dart';
import 'package:media_tooker/screens/pages/chat_page.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/text_widget.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final searchController = TextEditingController();

  String nameSearched = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: primary,
        ),
        onPressed: () {},
      ),
      body: SafeArea(
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
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              TextWidget(
                text: 'Messages',
                fontSize: 32,
                fontFamily: 'Bold',
                color: primary,
              ),
              const SizedBox(
                width: 50,
              ),
            ],
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
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChatPage()));
                    },
                    child: const CircleAvatar(
                      maxRadius: 35,
                      minRadius: 35,
                      backgroundImage:
                          AssetImage('assets/images/default_logo.png'),
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.white,
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage()));
                      },
                      leading: const CircleAvatar(
                        maxRadius: 40,
                        minRadius: 40,
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
                      title: TextWidget(
                        text: 'John Doe',
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'Bold',
                      ),
                      subtitle: TextWidget(
                        text: 'Hey whats up!',
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Regular',
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}
