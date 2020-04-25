import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

Widget loadingIndicator() {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Platform.isAndroid
          ? CircularProgressIndicator()
          : CupertinoActivityIndicator(),
    ),
  );
}
