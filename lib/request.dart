import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visionary_forge/home.dart';

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
      appBar: AppBar(
        backgroundColor: buttonCol,
        title: const Text('Requests'),
      ),
      backgroundColor: bkGnd,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Ideas').snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot<Object>? item =
                          snapshot.data!.docs[index];
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
                              child: Container(
                                color: buttonCol,
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                child: Center(
                                    child: Text(
                                  item['title'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                )
              : const CircularProgressIndicator();
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
      backgroundColor: bkGnd,
      appBar: AppBar(
        title: Text(widget.item!['title']),
      ),
      body: SizedBox(
        height: 850,
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
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        String myItem = snapshot.data!.docs[index]['message'];
                        userId = snapshot.data!.docs[index]['userId'];
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      myItem,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  snapshot.data!.docs[index]['approved'] == true
                                      ? SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.contact_mail,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['contact'],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.dangerous_sharp,
                                                color: Colors.yellow,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Not yet approved',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                  snapshot.data!.docs[index]['approved'] ==
                                          false
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                              InkWell(
                                                  onTap: () {
                                                    FirebaseFirestore.instance
                                                        .collection('Ideas')
                                                        .doc(widget.item!.id)
                                                        .collection('request')
                                                        .doc(snapshot.data!
                                                            .docs[index].id)
                                                        .delete();
                                                    setState(() {});
                                                  },
                                                  child: const Icon(Icons.close,
                                                      color: Colors.red)),
                                              InkWell(
                                                  onTap: () {
                                                    FirebaseFirestore.instance
                                                        .collection('Ideas')
                                                        .doc(widget.item!.id)
                                                        .collection('request')
                                                        .doc(snapshot.data!
                                                            .docs[index].id)
                                                        .update(
                                                            {'approved': true});

                                                    setState(() {});
                                                  },
                                                  child: const Icon(Icons.check,
                                                      color: Colors.green)),
                                            ])
                                      : Container(),
                                ]),
                          ),
                        );
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
