import 'package:flutter/material.dart';

class LoadLocation extends StatelessWidget {
  const LoadLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
