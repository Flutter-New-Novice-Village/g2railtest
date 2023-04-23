import 'package:flutter/material.dart';

goto(BuildContext context, Widget toWhere, {bool r = false}) async {
  if (!r) {
    return await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) {
      return toWhere;
    }));
  } else {
    return await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return toWhere;
    }));
  }
}

popBack(BuildContext context, {dynamic rtn}) {
  Navigator.of(context).pop(rtn);
}

GestureDetector tap(Widget child, Function click) {
  return GestureDetector(
    child: child,
    onTap: () {
      click();
    },
  );
}

void dismissKeyBoard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
