import 'package:flutter/material.dart';
import 'package:g2railtest/contant.dart';
import 'package:g2railtest/screen/detail_screen.dart';
import 'package:g2railtest/utils/ui_utils.dart';
import 'package:g2railtest/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text("首頁", s: 24),
      ),
      body: ctn(
          ListView(children: [
            space(h: 80),
            Row(children: [space(), text("我是首頁", s: 24)]),
            space(),
            btn("前往下一頁", () {
              if (!mounted) return;
              goto(context, const DetailScreen());
            }, w: sw - 32, h: 80, cr: 10, m: 10)
          ]),
          w: sw,
          h: sh),
    );
  }
}
