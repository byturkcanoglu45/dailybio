import 'package:dailybio/constants.dart';
import 'package:flutter/material.dart';

void snack_bar(content, GlobalKey<ScaffoldState> scaffoldKey) {
  final snackbar = new SnackBar(
    content: Text(
      content,
      style: kGoogleFont.copyWith(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    backgroundColor: Color(0xffff7e67),
    duration: Duration(seconds: 3),
  );

  scaffoldKey.currentState.showSnackBar(snackbar);
}
