import 'package:flutter/material.dart';
import 'blackdot_page.dart';
import 'plants_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0; // 0代表黑点页面，1代表植物页面

  // 这个方法用来构建底部导航栏的按钮
  // 这里的 index 是按钮的索引，iconData 是图标数据
  // 选中的按钮会有不同的颜色和图标
  Widget _buildIconButton(int index, IconData iconData) {
    bool isSelected = _currentPageIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentPageIndex = index; // 只有点了才切换
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color:
              isSelected
                  ? (_currentPageIndex == 0
                      ? Colors.blueAccent
                      : Colors.blueGrey) // 选中的更深
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(iconData, color: isSelected ? Colors.white : Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 252, 214), // 背景色
      body: IndexedStack(
        index: _currentPageIndex,
        children: const [PlantsPage(), BlackDotPage()],
      ),
      bottomNavigationBar: BottomAppBar(
        color:
            _currentPageIndex == 0
                ? const Color.fromARGB(255, 250, 252, 214)
                : Colors.black, // 根据当前页面背景变色
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    _currentPageIndex == 0
                        ? const Color.fromARGB(255, 250, 252, 214)
                        : Colors.black, // 小框框的颜色
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIconButton(0, Icons.nature), // 植物页按钮
                  const SizedBox(width: 8),
                  _buildIconButton(1, Icons.blur_on), // 点阵页按钮（你可以换成别的图标）
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
