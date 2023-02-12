import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IdeaCollaborationScreen extends StatefulWidget {
  final String? ideaId;
  const IdeaCollaborationScreen({this.ideaId});

  @override
  _IdeaCollaborationScreenState createState() =>
      _IdeaCollaborationScreenState();
}

class _IdeaCollaborationScreenState extends State<IdeaCollaborationScreen> {
  final _chatController = TextEditingController();
  final _discussionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collaborate on Idea'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Ideas')
                    .doc(widget.ideaId)
                    .collection('chat')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child:
                                  Text(snapshot.data!.docs[index]['message']),
                            ),
                            FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(snapshot.data!.docs[index]['userId'])
                                    .get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      snapshot.data!['username'],
                                    ),
                                  );
                                }),
                          ],
                        );
                      });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _chatController,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('Ideas')
                      .doc(widget.ideaId)
                      .collection('chat')
                      .add({
                    'message': _chatController.text,
                    'timestamp': Timestamp.now(),
                    'userId': auth!.uid,
                  });
                  _chatController.clear();
                },
                child: const Text('Send'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _discussionController,
                decoration: const InputDecoration(
                  hintText: 'Add as a Collaborator',
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('Ideas')
                      .doc(widget.ideaId)
                      .collection('request')
                      .add({
                    'message': _discussionController.text,
                    'timestamp': Timestamp.now(),
                    'userId': auth!.uid,
                  });
                  _discussionController.clear();
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
