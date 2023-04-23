import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:g2railtest/contant.dart';
import 'package:g2railtest/utils/utils.dart';

Text text(String txt, {double s = 12, Color? c, bool b = false}) {
  return Text(
    txt,
    style: TextStyle(
        fontSize: s, color: c, fontWeight: b ? FontWeight.bold : null),
  );
}

Widget ctn(Widget child,
    {Color? c, double? w, double? h, double? cr, double p = 0, double m = 0}) {
  return Container(
    width: w,
    height: h,
    padding: EdgeInsets.all(p),
    margin: EdgeInsets.all(m),
    decoration: BoxDecoration(
        color: c, borderRadius: cr == null ? null : BorderRadius.circular(cr)),
    child: child,
  );
}

Widget btn(String title, Function click,
    {double? w,
    double? h,
    double? cr,
    Color bc = primary,
    double ts = 16,
    Color? tc = white,
    double p = 0.0,
    double m = 0.0}) {
  return tap(
      ctn(center(text(title, s: ts, c: tc)),
          w: w, h: h, cr: cr, c: bc, p: p, m: m), () {
    click();
  });
}

Widget center(Widget child) {
  return Center(child: child);
}

Widget space({double h = 16, double w = 16}) {
  return SizedBox(
    height: h,
    width: w,
  );
}

toast(String str) {
  EasyLoading.showToast(str);
}

loading(bool show) {
  if (show) {
    EasyLoading.show();
  } else {
    EasyLoading.dismiss();
  }
}
