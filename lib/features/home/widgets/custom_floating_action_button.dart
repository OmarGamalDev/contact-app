import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onAddPressed;
  final VoidCallback onClearPressed;

  const CustomFloatingActionButton({
    super.key,
    required this.onAddPressed,
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          backgroundColor: const Color(0xffF93E3E),
          onPressed: onClearPressed,
          child: const Icon(Icons.delete),
        ),
        SizedBox(height: 10.h),
        FloatingActionButton(
          backgroundColor: const Color(0xffFFF1D4),
          onPressed: onAddPressed,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
