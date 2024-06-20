import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

void showToast({required BuildContext context, required Widget child}) {
  return FToast().init(context).showToast(
        toastDuration: const Duration(seconds: 5),
        gravity: ToastGravity.TOP,
        child: child,
      );
}

class ToastWidget extends StatelessWidget {
  final Color? backgroundColor, borderColor;
  final String? message;
  final EdgeInsetsGeometry? margin;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final double? fontSize;
  final double? marginTop;
  final bool? isCenter;

  const ToastWidget({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.message,
    this.margin,
    this.fontWeight,
    this.lineHeight,
    this.fontSize = 16,
    this.marginTop,
    this.isCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Container(
        padding:  EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: backgroundColor!,
          border: Border.all(color: borderColor!, width: 1.w),
          borderRadius: BorderRadius.circular(4.r),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: (isCenter == true)
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                message!,
                style: GoogleFonts.nunito(
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
