import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addNotifUser(name, freelancerId) async {
  final docUser = FirebaseFirestore.instance.collection('Notifs').doc();

  final json = {
    'name': name,
    'dateTime': DateTime.now(),
    'id': docUser.id,
    'freelancerId': freelancerId,
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'isSeen': false
  };

  await docUser.set(json);
}

Future addNotifFreelancer(name, userId) async {
  final docUser = FirebaseFirestore.instance.collection('Notifs').doc();

  final json = {
    'name': name,
    'dateTime': DateTime.now(),
    'id': docUser.id,
    'userId': userId,
    'freelancerId': FirebaseAuth.instance.currentUser!.uid,
    'isSeen': false
  };

  await docUser.set(json);
}
