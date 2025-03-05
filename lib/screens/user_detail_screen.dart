import 'package:flutter/material.dart';
import '../models/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: Container(
        color: Colors.lightBlue[100], // Sets background color to sky blue
        width: double.infinity, // Ensures full width coverage
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 50, backgroundImage: NetworkImage(user.picture)),
              SizedBox(height: 10),
              Text('ID: ${user.id}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Name: ${user.title} ${user.firstName} ${user.lastName}', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

