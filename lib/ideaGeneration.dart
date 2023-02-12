import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionary_forge/home.dart';

class IdeaGenerationPage extends StatefulWidget {
  @override
  _IdeaGenerationPageState createState() => _IdeaGenerationPageState();
}

class _IdeaGenerationPageState extends State<IdeaGenerationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _ideaAuthor;
  String? _ideaTitle;
  String? _ideaDescription;
  String? _ideaSolution;
  String? _ideaProblem;
  final ref = FirebaseFirestore.instance.collection('Ideas');

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Idea Generation"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: "Idea Author"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the author of the idea";
                  }
                  return null;
                },
                onSaved: (value) {
                  _ideaAuthor = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Idea Title"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the title of the idea";
                  }
                  return null;
                },
                onSaved: (value) {
                  _ideaTitle = value;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: "Problem being solved"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the title of the idea";
                  }
                  return null;
                },
                onSaved: (value) {
                  _ideaProblem = value;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: "Solution being provided"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the title of the idea";
                  }
                  return null;
                },
                onSaved: (value) {
                  _ideaSolution = value;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: "Idea Description"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the description of the idea";
                  }
                  return null;
                },
                onSaved: (value) {
                  _ideaDescription = value;
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: buttonCol),
                child: const Text("Submit Idea"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Add the idea to the database or data source here
                    Map<String, String> map = {
                      'title': _ideaTitle!,
                      'author': _ideaAuthor!,
                      'authorId': auth!.uid,
                      'desc': _ideaDescription!,
                      'problem_statement': _ideaProblem!,
                      'solution': _ideaSolution!,
                    };

                    ref.add(map);
                    //Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
