import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/colors.dart';
import '../resources/font.dart';





Widget commonTextField(
    TextEditingController controller,
    FocusNode focusNode,
    double width,
    Function(String) onChanged, {
      String hint = "",
      double radius = 30.0,
      double borderWidth = 1.0,
      Color borderColor = Colors.black,
      Color focusBorderColor = const Color(0xFF00BCD4),
      Color fillColor = Colors.white,
      TextStyle? hintStyle,
      TextStyle? textStyle,
      bool obscureText = false,
      TextInputType keyboardType = TextInputType.text,
      Widget? prefixIcon,
      Widget? suffixIcon,
    }) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isPasswordVisible = !obscureText;

      return Focus(
        onFocusChange: (_) => setState(() {}),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: focusNode.hasFocus ? focusBorderColor : borderColor,
              width: borderWidth,
            ),
            boxShadow: focusNode.hasFocus
                ? [
              BoxShadow(
                color: focusBorderColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ]
                : [],
          ),
          child: StatefulBuilder(
            builder: (context, setInnerState) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                obscureText: obscureText && !isPasswordVisible,
                keyboardType: keyboardType,
                style: textStyle ?? const TextStyle(color: Colors.black),
                onChanged: onChanged,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  hintText: hint,
                  hintStyle: hintStyle ?? const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: prefixIcon,
                  suffixIcon: obscureText
                      ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      setInnerState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                      : suffixIcon,
                ),
              );
            },
          ),
        ),
      );
    },
  );
}



Widget commonButton(
  double width,
  double height,
  Color backgroundColor,
  Color color,
  VoidCallback? onChanged, {
  String hint = '',
  double radius = 12,
  double paddingVertical = 0,
  double paddingHorizontal = 0,
  double fontSize = 16,
  Color borderColor = Colors.transparent,
}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        vertical: paddingVertical,
        horizontal: paddingHorizontal,
      ),
      minimumSize: Size(width, height),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor, width: 1),
      ),
    ),
    child: Text(
      hint,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: appFonts.NunitoBold,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}

Widget commonButtonWithLoader(
  double width,
  double height,
  Color backgroundColor,
  Color color,
  Rx<bool> isLoading,
  VoidCallback? onChanged, {
  String hint = '',
  TextStyle? hintStyle,
  double radius = 12,
  double paddingVertical = 0,
  double paddingHorizontal = 0,
  double fontSize = 16,
  Color borderColor = Colors.transparent,
}) {
  return Obx(
    () => ElevatedButton(
      onPressed: isLoading.value ? null : onChanged, // Disable when loading
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        minimumSize: Size(width, height),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: isLoading.value
          ? SizedBox(
              width: fontSize,
              height: fontSize,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            )
          : Text(
              hint,
              style: hintStyle ?? TextStyle(color: Colors.white70),
            ),
    ),
  );
}



Widget commonSearchBar(
    double width,
    double height,
    String hintText, {
      TextStyle? hintStyle,
      Color fillColor = Colors.white,
      Color borderColor = Colors.transparent,
      double borderRadius = 24,
      Widget? prefixIcon,
      Widget? suffixIcon,
      EdgeInsetsGeometry contentPadding =
      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ValueChanged<String>? onChanged,
    }) {
  return SizedBox(
    width: width,
    height: height,
    child: TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ??
            const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
      ),
    ),
  );
}
