
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Splash Screen'),
          ElevatedButton(
              onPressed: () => {},
              child: Text('Login'),

          ),
        ],
      ),
    );
  }
}