import 'package:flutter/material.dart';
import 'blackdot_page.dart';
import 'plants_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [
        BlackDotPage(),
        PlantsPage(),
      ],
    );
  }
}
