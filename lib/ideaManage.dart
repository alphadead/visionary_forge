import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visionary_forge/home.dart';

class IdeaManage extends StatefulWidget {
  const IdeaManage({Key? key}) : super(key: key);

  @override
  State<IdeaManage> createState() => _IdeaManageState();
}

class _IdeaManageState extends State<IdeaManage> {
  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: bkGnd,
      appBar: AppBar(
        backgroundColor: buttonCol,
        title: const Text('Manage your Ideas'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: db.collection('Ideas').snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot item = snapshot.data!.docs[index];
                      if (item['authorId'] == auth!.uid) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                item['title'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                item['desc'],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonCol),
                              onPressed: () {
                                db.collection('Ideas').doc(item.id).delete();
                              },
                              child: const Text(
                                'Delete Idea',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    })
                : const Text('No Idea existing, Add your!');
          },
        ),
      ),
    );
  }
}
