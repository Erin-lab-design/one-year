import 'package:flutter/material.dart';

class PlantsPage extends StatefulWidget {
  const PlantsPage({Key? key}) : super(key: key);

  @override
  State<PlantsPage> createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  late List<bool> _grownDays; // 记录每一天是否已经长出植物
  final int totalDays = 365;

  @override
  void initState() {
    super.initState();
    DateTime today = DateTime.now();
    _grownDays = List.generate(totalDays, (index) {
      // 今天之前的日子都种上植物
      DateTime day = DateTime(today.year, 1, 1).add(Duration(days: index));
      return day.isBefore(today) || day.isAtSameMomentAs(today);
    });
  }

  void _growPlant(int index) {
    setState(() {
      _grownDays[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 252, 214),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 18, // 18列
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
          ),
          itemCount: totalDays,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (!_grownDays[index]) {
                  _growPlant(index);
                }
              },
              child:
                  _grownDays[index]
                      ? Image.asset('assets/plant_${index % 14}.png') // 用不同植物图案
                      : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(
                            123,
                            0,
                            197,
                            23,
                          ).withOpacity(0.5),
                        ),
                        width: 8,
                        height: 8,
                      ),
            );
          },
        ),
      ),
    );
  }
}
