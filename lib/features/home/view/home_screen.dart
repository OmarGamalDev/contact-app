import 'dart:io';

import 'package:contact_app/features/home/model/contact_model.dart';
import 'package:contact_app/features/home/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  static const routename = "home";
  List<ContactModel> contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff29384D),
      floatingActionButton: CustomFloatingActionButton(),
      body: contacts.isEmpty? 
      Center(
        child: Column(
          children: [
            SizedBox(height: 150.h),
            Image.asset(
              'assets/images/contact_image.png',
              fit: BoxFit.cover,
              width: 368.w,
              height: 368.h,
            ),
            Text(
              'There is No Contacts Added Here',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ):
      ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: contact.image.isNotEmpty
                  ? FileImage(File(contact.image))
                  : AssetImage('assets/images/default_avatar.png')
                      as ImageProvider,
            ),
            title: Text(
              contact.name,
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
            subtitle: Text(
              contact.phoneNumber,
              style: TextStyle(color: Colors.white70, fontSize: 16.sp),
            ),
          );
        },
      ),
    );
  }
}
