import 'package:first_app/weatherPage.dart';
import 'package:first_app/commutePage.dart';
import 'package:first_app/meetingsPage.dart';
import 'package:first_app/officePage.dart';
import 'package:first_app/teamPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Smart Notification System',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.grey,
      ),
      body: const MyStatefulWidget(),
    ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        fixedSize: const Size(300, 80));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WeatherPage()),
              );
            },
            child: const Text('Weather'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MeetingsPage()),
              );
            },
            child: const Text('Meetings'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TeamPage()),
              );
            },
            child: const Text('Team'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommutePage()),
              );
            },
            child: const Text('Commute'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OfficePage()),
              );
            },
            child: const Text('Office'),
          ),
        ],
      ),
    );
  }
}
