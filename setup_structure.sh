#!/bin/bash

cd lib || exit

# 创建目录
mkdir -p pages widgets

# 创建 Dart 文件
touch pages/home_page.dart
touch pages/days_left_page.dart
touch pages/plants_page.dart
touch widgets/day_dot.dart

echo "✅ Flutter 文件结构已生成完毕！"
