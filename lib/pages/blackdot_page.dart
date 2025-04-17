import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/day_dot.dart';

class BlackDotPage extends StatelessWidget {
  const BlackDotPage({super.key});

  int getDayOfYear() {
    final now = DateTime.now();
    return int.parse(DateFormat("D").format(now));
  }

  int getTotalDaysInYear() {
    final now = DateTime.now();
    final end = DateTime(now.year, 12, 31);
    final start = DateTime(now.year, 1, 1);
    return end.difference(start).inDays + 1;
  }

  @override
  Widget build(BuildContext context) {
    final dayOfYear = getDayOfYear();
    final totalDays = getTotalDaysInYear();
    final daysLeft = totalDays - dayOfYear;

    const dotSize = 3.0;
    const crossAxisSpacing = 8.0;
    const horizontalPadding = 12.0;
    const verticalPadding = 12.0;

    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(horizontalPadding),
          child: Column(
            children: [
              // 文字区域由系统占高
              Text(
                '$totalDays ••• days',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                '$daysLeft days left this year',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: verticalPadding),

              // 点阵区域
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final availableWidth = constraints.maxWidth;
                    final availableHeight = constraints.maxHeight;

                    // 横向：一行最多放多少列（点 + 间距）
                    final crossAxisCount = (availableWidth / (dotSize + crossAxisSpacing)).floor();

                    // 需要多少行才能放下 totalDays 个点
                    final requiredRows = (totalDays / crossAxisCount).ceil();

                    // 多加一行：用于空白
                    //final  requiredRows = requiredRows + 1;

                    // 每个点占据 dotSize，高度剩下的都给间距分掉
                    final totalDotHeight = requiredRows * dotSize;

                    // 计算行间距（剩下的空间均分到 requiredRows - 1 个间隔）
                    final mainAxisSpacing = (availableHeight - totalDotHeight) / (requiredRows);

                    // 点的总数：只到 totalDays
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: crossAxisSpacing,
                        mainAxisSpacing: mainAxisSpacing,
                      ),
                      itemCount: totalDays,
                      itemBuilder: (context, index) {
                        final isPast = index < dayOfYear;
                        final isToday = index == dayOfYear;
                        return DayDot(isPast: isPast, isToday: isToday);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
