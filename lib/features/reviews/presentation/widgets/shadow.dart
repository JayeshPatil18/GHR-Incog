import 'package:flutter/cupertino.dart';

import '../../../../constants/shadow_color.dart';

class ContainerShadow {
  static final List<BoxShadow> boxShadow = [
    BoxShadow(
      color: AppShadowColors.topShadow,
      offset: Offset(-4.0, -4.0),
      blurRadius: 10,
      spreadRadius: 0.0,
    ),
    BoxShadow(
      color: AppShadowColors.bottomShadow,
      offset: Offset(4.0, 4.0),
      blurRadius: 10,
      spreadRadius: 0.0,
    ),
  ];
}