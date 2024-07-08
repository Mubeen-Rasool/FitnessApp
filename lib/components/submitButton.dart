import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Widget? image;

  CustomButton({
    required this.text,
    required this.onTap,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      child: Container(
        width: 320.w,
        height: 48.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xff8ddfff), // Left side color
              Color(0xff208ebe), // Right side color
            ],
            stops: [0.4, 1.0],// Adjust stops to control color distribution
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          borderRadius: BorderRadius.circular(30.0.r),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(20, 108, 148, 0.24),
              offset: const Offset(0, 3),
              blurRadius: 1.r,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (image != null) ...[
                Padding(
                  padding: EdgeInsets.only(right: 2.0.w),
                  child: SizedBox(
                    width: 30.w,
                    height: 30.h,
                    child: image!,
                  ),
                ),
              ],
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
