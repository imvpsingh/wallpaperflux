import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaperflux/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
  MobileAds.instance.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HD WALLPAPER',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: const HomeScreen(),
    );
  }
}
