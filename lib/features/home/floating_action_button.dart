import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        
      },
      backgroundColor: Color(0xffFFF1D4),
      child: Icon(Icons.add, size: 30.0),
    );
  }
}