import 'package:flutter/material.dart';
import '../widgets/day_dot.dart';

int getDayOfYear() {
  final now = DateTime.now();
  final startOfYear = DateTime(now.year, 1, 1);
  return now.difference(startOfYear).inDays + 1;
}

int getTotalDaysInYear() {
  final now = DateTime.now();
  final nextYear = DateTime(now.year + 1, 1, 1);
  final startOfYear = DateTime(now.year, 1, 1);
  return nextYear.difference(startOfYear).inDays;
}

class BlackDotPage extends StatelessWidget {
  const BlackDotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int dayOfYear = getDayOfYear();
    final int totalDays = getTotalDaysInYear();
    final int daysLeft = totalDays - dayOfYear;

    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        // ✅ 改动①：添加 SafeArea，避免遮挡
        child: LayoutBuilder(
          builder: (context, constraints) {
            const double dotSize = DayDot.dotSize; // match DayDot size
            const double topReservedHeight = 130.0;

            final double gridAreaWidth = constraints.maxWidth;
            final double gridAreaHeight =
                constraints.maxHeight - topReservedHeight;

            // ✅ 尝试找到最合适的列数，使得能容纳至少 totalDays 个点
            int bestColumnCount = 1;
            int bestRowCount = totalDays;

            for (int columns = 1; columns <= totalDays; columns++) {
              int rows = (totalDays / columns).ceil();

              double hSpacing =
                  (gridAreaWidth - columns * dotSize) / (columns - 1);
              double vSpacing = (gridAreaHeight - rows * dotSize) / (rows - 1);

              if (hSpacing > 0 &&
                  vSpacing > 0 &&
                  (hSpacing - vSpacing).abs() < 4) {
                // 找到间距比较接近理想方格的情况
                bestColumnCount = columns;
                bestRowCount = rows;
                break;
              }
            }

            final double hSpacing =
                (gridAreaWidth - bestColumnCount * dotSize) /
                (bestColumnCount - 1);
            final double vSpacing =
                (gridAreaHeight - bestRowCount * dotSize) / (bestRowCount - 1);

            // 打印调试信息
            print(
              '📐 Dot grid layout: $bestColumnCount columns × $bestRowCount rows',
            );
            print(
              '↔️ hSpacing: ${hSpacing.toStringAsFixed(2)} | ↕️ vSpacing: ${vSpacing.toStringAsFixed(2)}',
            );

            return Column(
              children: [
                const SizedBox(height: 50),
                Column(
                  children: [
                    Text(
                      '$totalDays ••• days',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$daysLeft days left this year',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: gridAreaWidth * 0.98, // ✅ 改动③：略微缩小宽度
                      height: gridAreaHeight * 0.98, // ✅ 改动④：略微缩小高度
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: totalDays,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: bestColumnCount,
                          crossAxisSpacing: hSpacing,
                          mainAxisSpacing: vSpacing,
                        ),
                        itemBuilder: (context, index) {
                          return DayDot(isPast: index <= dayOfYear - 1);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
