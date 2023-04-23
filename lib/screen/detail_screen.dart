import 'package:flutter/material.dart';
import 'package:g2railtest/contant.dart';
import 'package:g2railtest/utils/ui_utils.dart';
import 'package:g2railtest/utils/utils.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: text("內容頁", s: 24),
        ),
        body: ctn(
            Column(children: [
              space(h: 80),
              text("我是內容頁", s: 24),
              space(),
              btn("回到上一頁", () {
                if (!mounted) return;
                popBack(context);
              }, w: sw - 32, h: 80, cr: 10, m: 10)
            ]),
            w: sw,
            h: sh));
  }
}
