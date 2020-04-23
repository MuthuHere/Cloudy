import 'package:flutter/material.dart';

///[backgroundDecoration] is for background
Decoration backgroundDecoration() => BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/ic_cloud_bg.jpg"),
        fit: BoxFit.fill,
      ),
    );
