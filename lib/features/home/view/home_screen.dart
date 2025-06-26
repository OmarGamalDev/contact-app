import 'package:contact_app/features/home/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routename = "home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff29384D),
      floatingActionButton: CustomFloatingActionButton(),
      body: Column(
        children: [
          SizedBox(height: 150.h),
          Image.asset(
            'assets/images/contact_image.png',
            fit: BoxFit.cover,
            width: 368.w,
            height: 368.h,
          ),
          Center(
            child: Text(
              'There is No Contacts Added Here',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
