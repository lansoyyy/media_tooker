import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addBooking(
    name, date, time, note, label, freelancerId, freelancerName, job) async {
  final docUser = FirebaseFirestore.instance.collection('Bookings').doc();

  final json = {
    'name': name,
    'date': date,
    'time': time,
    'note': note,
    'label': label,
    'dateTime': DateTime.now(),
    'id': docUser.id,
    'freelancerId': freelancerId,
    'freelancerName': freelancerName,
    'job': job,
    'myId': FirebaseAuth.instance.currentUser!.uid,
    'status': 'Pending',
    'isCompleted': false
  };

  await docUser.set(json);
}
