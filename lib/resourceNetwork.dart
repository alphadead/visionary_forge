import 'package:flutter/material.dart';

class ResourcesPage extends StatefulWidget {
  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Funding Opportunities'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => FundingPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Networking Opportunities'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => NetworkingPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FundingPage extends StatefulWidget {
  @override
  _FundingPageState createState() => _FundingPageState();
}

class _FundingPageState extends State<FundingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funding Opportunities'),
      ),
      body: Container(
        child: const Center(
          child: Text('This is the Funding Opportunities page'),
        ),
      ),
    );
  }
}

class NetworkingPage extends StatefulWidget {
  @override
  _NetworkingPageState createState() => _NetworkingPageState();
}

class _NetworkingPageState extends State<NetworkingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Networking Opportunities'),
      ),
      body: Container(
        child: const Center(
          child: Text('This is the Networking Opportunities page'),
        ),
      ),
    );
  }
}
