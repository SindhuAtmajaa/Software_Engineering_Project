library alert;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Future showProgressDialog({
  required BuildContext context,
  bool isDismissible = false,
}) {
  return showDialog(
    context: context,
    barrierDismissible: isDismissible,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (context) => WillPopScope(
      onWillPop: () async => isDismissible,
      child: Dialog(
        elevation: 0,
        insetPadding: const EdgeInsets.all(64),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Builder(
          builder: (context) => Container(
            width: 100.w,
            height: 110.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Loading..",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: 38.w,
                  height: 38.h,
                  child: const CircularProgressIndicator(
                    color: Color(0xffB311FF),
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget circularProgress(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          color: Color(0xffB311FF),
          backgroundColor: Colors.white,
        )
      ],
    ),
  );
}
