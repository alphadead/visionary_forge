import 'package:flutter/material.dart';

class ProjectManagementPage extends StatefulWidget {
  @override
  _ProjectManagementPageState createState() => _ProjectManagementPageState();
}

class _ProjectManagementPageState extends State<ProjectManagementPage> {
  final _formKey = GlobalKey<FormState>();

  String? _projectName;
  String? _projectDescription;
  String? _projectMilestones;
  String? _projectProgress;
  String? _projectBudget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Management"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: "Project Name"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a project name";
                  }
                  return null;
                },
                onSaved: (value) => _projectName = value,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: "Project Description"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a project description";
                  }
                  return null;
                },
                onSaved: (value) => _projectDescription = value,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: "Project Milestones"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter project milestones";
                  }
                  return null;
                },
                onSaved: (value) => _projectMilestones = value,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: "Project Progress"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter project progress";
                  }
                  return null;
                },
                onSaved: (value) => _projectProgress = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Project Budget"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter project budget";
                  }
                  return null;
                },
                onSaved: (value) => _projectBudget = value!,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Use the information in _projectName, _projectDescription, _projectMilestones, _projectProgress, and _projectBudget
                    // to save the project to a database or local storage
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
