import 'package:flutter/material.dart';

import '../resources/colors.dart';

class AppGradients {
  static final LinearGradient appBarGradient = LinearGradient(
    colors: [appColors.primary, appColors.gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );


}
