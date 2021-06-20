import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/widgets.dart';

class Streak {
  final int length; // length of the streak
  final String name; // name of the streak

  Streak(
      { this.length,
        this.name,
      });

  Streak.fromMap(Map<String, dynamic> res)
      : length = res["length"],
        name = res["name"];

  Map<String, Object> toMap() {
    return {'length':length,'name': name};
  }
}