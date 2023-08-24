import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/shadow_color.dart';

class ContainerShadow {
  static final List<BoxShadow> boxShadow = [
    BoxShadow(
      color: AppShadowColors.topShadow,
      offset: Offset(-3, -3),
      blurRadius: 8,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: AppShadowColors.bottomShadow,
      offset: Offset(3, 3),
      blurRadius: 8,
      spreadRadius: 1.0,
    ),
  ];
}

class TopContainerShadow {
  static final List<BoxShadow> boxShadow = [
    BoxShadow(
      color: AppShadowColors.topShadow,
      offset: Offset(-3, -3),
      blurRadius: 8,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: AppShadowColors.bottomShadow,
      offset: Offset(3, 3),
      blurRadius: 8,
      spreadRadius: 1.0,
    ),
  ];
}
  
class TextShadow {
  static final BoxShadow textShadow= BoxShadow(
        offset: Offset(0.0, 0.0),
        blurRadius: 20,
        color: Colors.white,
        spreadRadius: 1
      );
}
  