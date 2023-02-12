import 'package:flutter/material.dart';

class ImpactMeasurementPage extends StatefulWidget {
  @override
  _ImpactMeasurementPageState createState() => _ImpactMeasurementPageState();
}

class _ImpactMeasurementPageState extends State<ImpactMeasurementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impact Measurement'),
      ),
      body: Container(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Track your project impact',
                  style: TextStyle(fontSize: 24)),
            ),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    title: Text('Metric 1'),
                    subtitle: Text('Number of people reached'),
                  ),
                  ListTile(
                    title: Text('Metric 2'),
                    subtitle: Text('Amount of money saved'),
                  ),
                  ListTile(
                    title: Text('Metric 3'),
                    subtitle: Text('Number of trees planted'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
