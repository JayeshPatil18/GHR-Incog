import 'package:flutter/cupertino.dart';

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