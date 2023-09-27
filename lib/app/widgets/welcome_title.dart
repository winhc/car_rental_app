import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 50.sp,
            fontFamily: "Pacifico-Regular"));
  }
}
