import 'package:flutter/material.dart';

class DayDot extends StatelessWidget {
  final bool isPast;
  final bool isToday;

  const DayDot({super.key, required this.isPast, this.isToday = false});

  @override
  Widget build(BuildContext context) {
    final double size = isPast ? 3 : isToday ? 3 : 3;
    final Color baseColor = isPast
    ? Color.fromARGB(255, 255, 255, 255)
    : isToday
        ? Color.fromARGB(255, 254, 254, 0)
        : Color.fromARGB(70, 103, 103, 103);
    final color = baseColor.withOpacity(0.8);
  
    return Center(
      child : Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
          BoxShadow(
            color: color,
            //blurRadius: 1,
            //spreadRadius: 0,
          )
        ],
        ),
      ),
    );
  }
}
