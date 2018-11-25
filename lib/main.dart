import 'package:flutter/material.dart';
import './home/home_screen.dart';
import 'package:myapp/constants.dart' show AppColors;

void main() => runApp(MaterialApp(
  title: '微信',
//  theme: ThemeData(
//    primaryColor: Color(0xff303030),
//  ),
  theme: ThemeData.light().copyWith(
    primaryColor: Color(AppColors.AppBarColor),
    cardColor: Color(AppColors.AppBarColor),
  ),
  home: HomeScreen(),
));
