import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visionary_forge/ediProfile.dart';
import 'package:visionary_forge/home.dart';
import 'package:visionary_forge/login.dart';
import 'package:visionary_forge/request.dart';

CollectionReference ref = FirebaseFirestore.instance.collection('users');

class ProfileScreen extends StatelessWidget {
  final UserProfile? userProfile;

  const ProfileScreen({this.userProfile});

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: bkGnd,
      appBar: AppBar(
        backgroundColor: buttonCol,
        title: const Text('Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: ref.doc(auth!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) =>
                Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    snapshot.data!['username'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.data!['email'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(246, 148, 110, 1)),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const RequestScreen(),
                  ),
                );
              },
              child: const Text('Requests'),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: buttonCol),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        userProfile: snapshot.data!,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: buttonCol),
                onPressed: () {
                  FirebaseAuth.instance.signOut();

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfile {
  String? name;
  String? profilePicture;
  String? bio;
  String? contactInformation;

  UserProfile(
      {this.name, this.profilePicture, this.bio, this.contactInformation});
}
