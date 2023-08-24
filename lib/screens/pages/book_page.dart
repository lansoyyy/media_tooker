import 'package:flutter/material.dart';
import 'package:media_tooker/screens/pages/add_booking_page.dart';

import '../../utils/colors.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddBookingPage()));
        },
      ),
      body: Column(),
    );
  }
}
