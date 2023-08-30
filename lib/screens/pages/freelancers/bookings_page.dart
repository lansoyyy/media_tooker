import 'package:flutter/material.dart';
import 'package:media_tooker/screens/pages/freelancers/task_page.dart';
import 'package:media_tooker/utils/colors.dart';
import 'package:media_tooker/widgets/text_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  final tasknameController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final noteController = TextEditingController();
  final labelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const TaskPage()));
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: 'Bookings',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: TableCalendar(
        onDaySelected: (selectedDay, focusedDay) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Scheduled Bookings',
                        fontSize: 14,
                        fontFamily: 'Bold',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: TextWidget(
                                  text: 'Title here',
                                  fontSize: 18,
                                  fontFamily: 'Bold',
                                ),
                                subtitle: TextWidget(
                                  text: 'Description here',
                                  fontSize: 12,
                                  fontFamily: 'Regular',
                                ),
                                trailing: SizedBox(
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.remove_circle,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.add_circle_rounded,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
      ),
    );
  }
}
