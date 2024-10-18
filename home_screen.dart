import 'package:flutter/material.dart';
import 'stress_management_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          child: Text('Manage Stress'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StressManagementScreen()),
            );
          },
        ),
      ),
    );
  }
}