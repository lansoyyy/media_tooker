import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addMessage(freelancerId, message, freelancerName, userName,
    freelancerProfile, userProfile) async {
  final docUser = FirebaseFirestore.instance
      .collection('Messages')
      .doc(FirebaseAuth.instance.currentUser!.uid + freelancerId);

  final json = {
    'messages': [
      {
        'message': message,
        'dateTime': DateTime.now(),
        'sender': FirebaseAuth.instance.currentUser!.uid
      }
    ],
    'lastMessage': message,
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'freelancerId': freelancerId,
    'dateTime': DateTime.now(),
    'seen': false,
    'freelancerName': freelancerName,
    'userName': userName,
    'freelancerProfile': freelancerProfile,
    'userProfile': userProfile,
    'lastId': FirebaseAuth.instance.currentUser!.uid,
  };

  await docUser.set(json);
}
