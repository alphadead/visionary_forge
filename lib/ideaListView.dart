import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visionary_forge/collaborationPage.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class IdeaListView extends StatelessWidget {
  const IdeaListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: SizedBox(
        height: 500,
        child: StreamBuilder(
          stream: _db.collection('Ideas').snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot item = snapshot.data!.docs[index];
                      if (item['authorId'] != auth!.uid) {
                        return ListTile(
                          title: Text(item['title']),
                          subtitle: Text(item['desc']),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    IdeaDetailView(idea: item),
                              ),
                            );
                          },
                        );
                      }
                      return const CircularProgressIndicator();
                    })
                : const Text('Please Wait');
          },
        ),
      ),
    );
  }
}

class IdeaDetailView extends StatelessWidget {
  final DocumentSnapshot<Object?>? idea;

  const IdeaDetailView({Key? key, this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  IdeaCollaborationScreen(ideaId: idea!.id.toString()),
            ),
          );
        },
        child: const Text('+'),
      ),
      appBar: AppBar(
        title: Text(idea!['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Author: ${idea!['author']}'),
            const SizedBox(height: 16.0),
            Text('Description: ${idea!['desc']}'),
            const SizedBox(height: 16.0),
            Text('Votes: ${idea!['title']}'),
          ],
        ),
      ),
    );
  }
}
