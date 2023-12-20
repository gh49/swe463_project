import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;
    String? email = user.email;

    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Icon(Icons.person, size: 70),
            Text(
              "$email",
              style: TextStyle(
                fontSize: 12
              ),
            ),
            Text(
              "${userData?['name'] ?? ""}",
              style: TextStyle(
                  fontSize: 27
              ),
            ),
            Text(
              "Gender: ${userData?['gender'] ?? ""}",
              style: TextStyle(
                  fontSize: 10
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> getUserData() async {
    try {
      var firestore = FirebaseFirestore.instance;
      var userDoc = firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      var userSnp = await userDoc.get();
      print(userSnp.data());
      userData = userSnp.data();
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }
}
