import 'package:flutter/material.dart';

import '../../theme/themes.dart';

class MayaTextButton extends StatelessWidget {
  const MayaTextButton({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.fontSize,
    this.width,
    this.backgroundColor,
  });

  final void Function()? onPressed;
  final String buttonText;
  final double? fontSize;
  final double? width;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .06,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.green,
            foregroundColor: AppTheme.baseColor,
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: fontSize ?? AppTheme.sm, color: AppTheme.baseColor),
          ),
        ),
      ),
    );
  }
}
