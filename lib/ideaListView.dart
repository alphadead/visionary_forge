import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visionary_forge/collaborationPage.dart';
import 'package:visionary_forge/home.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class IdeaListView extends StatelessWidget {
  const IdeaListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: bkGnd,
      appBar: AppBar(
        title: const Text("Idea View"),
      ),
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
                        return Card(
                          child: ListTile(
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
                          ),
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

class IdeaDetailView extends StatelessWidget {
  final DocumentSnapshot<Object?>? idea;

  const IdeaDetailView({Key? key, this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkGnd,
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
            Card(
              child: ListTile(
                title: Text('Votes: ${idea!['title']}'),
                subtitle: Text('Description: ${idea!['desc']}'),
              ),
            ),
            Text('Author: ${idea!['author']}'),
          ],
        ),
      ),
    );
  }
}
