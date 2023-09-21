import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(name, address, email, type, id, doc, job, contactNumber) async {
  final docUser = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'name': name,
    'address': address,
    'email': email,
    'profilePicture': 'https://cdn-icons-png.flaticon.com/256/149/149071.png',
    'type': type,
    'status': 'Active',
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'id': id,
    'doc': doc,
    'job': job,
    'portfolio': [],
    'contactNumber': contactNumber,
    'isVerified': false,
  };

  await docUser.set(json);
}
