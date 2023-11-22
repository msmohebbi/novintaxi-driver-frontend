import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor.withAlpha(100),
        body: const SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
