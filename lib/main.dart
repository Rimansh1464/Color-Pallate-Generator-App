
import 'package:color_genertor_app/provider/color_provider.dart';
import 'package:color_genertor_app/provider/theme_provider.dart';
import 'package:color_genertor_app/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ColorProvider>(
          create: (context) => ColorProvider(),
      ),
      ChangeNotifierProvider<ThemeProvider>(create:(context) => ThemeProvider())
    ],
    builder: (context, _) => MaterialApp(
      theme: ThemeData(
          backgroundColor: Color(0xff9BA3EB), cardColor: Color(0xff646FD4)),
      darkTheme: ThemeData(
          backgroundColor: Color(0xff474E68), cardColor: Color(0xff6B728E)),
      themeMode:  (Provider.of<ThemeProvider>(context).isDark) ? ThemeMode.dark : ThemeMode.light,
      routes: {
        '/': (context) => HomeScreen(),
      },
    ),
  ));
}
