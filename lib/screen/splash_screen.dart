import 'package:flutter/material.dart';
import 'package:g2railtest/contant.dart';
import 'package:g2railtest/screen/home_screen.dart';
import 'package:g2railtest/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      goto(context, const HomeScreen(), r: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    sw = MediaQuery.of(context).size.width;
    sh = MediaQuery.of(context).size.height;

    return Container(
      color: white,
      child: const Center(
          child: CircularProgressIndicator(
        color: primary,
      )),
    );
  }
}
