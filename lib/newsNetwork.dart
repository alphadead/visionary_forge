import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:visionary_forge/home.dart';

class NetworkNews extends StatefulWidget {
  @override
  _NetworkNewsState createState() => _NetworkNewsState();
}

class _NetworkNewsState extends State<NetworkNews> {
  final String newsUrl =
      'https://newsapi.org/v2/everything?q=connections&apiKey=41e1981907e045f19cb9233b7fa3726d';
  List? newsData;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<String> getNews() async {
    var response = await http.get(
      Uri.parse(newsUrl),
      headers: {"Accept": "application/json"},
    );

    setState(() {
      var data = json.decode(response.body);
      newsData = data['articles'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkGnd,
      appBar: AppBar(
        backgroundColor: buttonCol,
        title: const Text('News on Networking'),
      ),
      body: ListView.builder(
        itemCount: newsData == null ? 0 : newsData!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: <Widget>[
                Text(
                  newsData![index]['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Image.network(newsData![index]['urlToImage']),
                Text(newsData![index]['description']),
              ],
            ),
          );
        },
      ),
    );
  }
}
