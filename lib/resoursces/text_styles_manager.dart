import 'package:flutter/material.dart';

import 'color_manager.dart';

class TextStyles{
  TextStyles._();

  static  TextStyle appBarTitle = TextStyle(
    color: ColorManager.darkColor,
    fontSize: 20,
    fontWeight: FontWeight.normal,
    );

      static  TextStyle appText = TextStyle(
    color: ColorManager.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    );
}