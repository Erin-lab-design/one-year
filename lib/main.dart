import 'package:flutter/material.dart';
import 'pages/home_page.dart';

//这里是应用入口，启动时会运行OneYearApp()，这是我们定义的根组件。
void main() {
  runApp(const OneYearApp());
}
//这就是整个 App 的包裹器，定义了主题、标题、默认页面。
class OneYearApp extends StatelessWidget {
  const OneYearApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Year',
      debugShowCheckedModeBanner: false, // 去掉右上角的 debug 标签
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black, // 黑色背景作为主色
        useMaterial3: true,
        fontFamily: 'Arial', // 你可以以后换成你喜欢的字体
      ),
      //启动后第一个页面就是我们写的 HomePage()，里面用 PageView 显示两个子页面（黑底点阵和花草页面）。
      home: const HomePage(), // 我们自己的主页面
    );
  }
}
