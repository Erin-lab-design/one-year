import 'package:flutter/material.dart';

class DayDot extends StatelessWidget {
  static const double dotSize = 4.0;
  final bool isPast;

  const DayDot({super.key, required this.isPast});

  @override
  // ✅ 改动1 Center + Container 改成 单独 Container。在BlackDotPage 中的 GridView 中已自动对齐，无需居中组件
  Widget build(BuildContext context) {
    final double size = dotSize;
    final Color color = isPast ? Colors.white : Colors.grey;

    return Container(
      width: size,
      height: size,
      // ✅ 改动2：去掉阴影。更简洁、节省性能、避免视觉模糊
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
