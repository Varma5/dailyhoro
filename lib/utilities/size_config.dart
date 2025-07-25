import 'package:flutter/material.dart';

import 'logger.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;
  static double statusBarHeight = 0.0;
  static EdgeInsets viewInsets = EdgeInsets.zero;

  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;
  static bool isTabPortrait = false;

  static late MediaQueryData _mediaQueryData;

  void init(
    BoxConstraints constraints,
    Orientation orientation,
    BuildContext context,
  ) {
    _mediaQueryData = MediaQuery.of(context);
    statusBarHeight = _mediaQueryData.viewPadding.top;
    viewInsets = _mediaQueryData.viewInsets;

    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (screenWidth < 550) {
        isMobilePortrait = true;
        isTabPortrait = false;
      } else {
        isMobilePortrait = false;
        isTabPortrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
      isTabPortrait = false;
    }

    _blockWidth = screenWidth / 100;
    _blockHeight = screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    Logger.doLog('_screenWidth $screenWidth');
    Logger.doLog('_screenHeight $screenHeight');
    Logger.doLog('textMultiplier $textMultiplier');
    Logger.doLog('imageSizeMultiplier $imageSizeMultiplier');
    Logger.doLog('heightMultiplier $heightMultiplier');
    Logger.doLog('widthMultiplier $widthMultiplier');
    Logger.doLog('isTabPortrait $isTabPortrait');
  }
}
