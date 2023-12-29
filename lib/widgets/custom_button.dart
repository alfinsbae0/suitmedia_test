import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    this.width,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.borderRadius = 55.0,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign,
    this.borderWidth = 1.0,
    this.elevation = 0,
    this.disable = false,
  });

  final String text;

  final double? height;

  final double? width;

  final Function()? onPressed;

  final Color? backgroundColor;

  final Color? borderColor;

  final double borderWidth;

  final TextStyle? textStyle;

  final double borderRadius;

  final Widget? prefixIcon;

  final Widget? suffixIcon;

  final TextAlign? textAlign;

  final double elevation;

  final bool disable;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disable ? null : onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize:
            width != null && height != null ? Size(width!, height!) : null,
        minimumSize: width != null && height != null ? const Size(0, 0) : null,
        backgroundColor: backgroundColor ?? Colors.transparent,
        elevation: disable ? 0 : elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            width: borderWidth,
            color: borderColor ?? Colors.transparent,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: prefixIcon != null,
            child: prefixIcon != null ? prefixIcon! : const Center(),
          ),
          Flexible(
            child: Text(
              text,
              style: textStyle,
              textAlign: textAlign,
            ),
          ),
          Visibility(
            visible: suffixIcon != null,
            child: suffixIcon != null ? suffixIcon! : const Center(),
          ),
        ],
      ),
    );
  }
}
