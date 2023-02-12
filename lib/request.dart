import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  User? auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Ideas').snapshots(),
        builder: (context, snapshot) {
          return SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot<Object>? item = snapshot.data!.docs[index];
                if (item['authorId'].toString() == auth!.uid.toString()) {
                  // String why = item['request']['message'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RequestDetail(item: item)));
                      },
                      child: Card(
                        child: Text(item['title']),
                      ),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          );
        },
      ),
    );
  }
}

class RequestDetail extends StatefulWidget {
  final DocumentSnapshot<Object>? item;
  const RequestDetail({Key? key, required this.item}) : super(key: key);

  @override
  State<RequestDetail> createState() => _RequestDetailState();
}

class _RequestDetailState extends State<RequestDetail> {
  @override
  Widget build(BuildContext context) {
    String? userId;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item!['title']),
      ),
      body: SizedBox(
        height: 250,
        child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('Ideas')
                .doc(widget.item!.id)
                .collection('request')
                .get(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        String myItem = snapshot.data!.docs[index]['message'];
                        userId = snapshot.data!.docs[index]['userId'];
                        return Center(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DeatilRquest(
                                        id: userId,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(myItem)));
                      }),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class DeatilRquest extends StatefulWidget {
  String? id;
  DeatilRquest({super.key, required this.id});

  @override
  State<DeatilRquest> createState() => _DeatilRquestState();
}

class _DeatilRquestState extends State<DeatilRquest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.id)
              .get(),
          builder: (context, snapshot) {
            return Text(snapshot.data!['username']);
          }),
    );
  }
}
