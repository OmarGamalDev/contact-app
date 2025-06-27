
import 'dart:io';
import 'package:contact_app/features/home/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  var status = await Permission.phone.status;
  if (!status.isGranted) {
    await Permission.phone.request();
  }

  if (await Permission.phone.isGranted) {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  } else {
    print("Phone permission not granted");
  }
}

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onDelete;

  const ContactCard({super.key, required this.contact, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 177.w,
      decoration: BoxDecoration(
        color: const Color(0xffFFF1D4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4)),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.file(
              File(contact.image),
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.w),
            child: Text(
              contact.name,
              style: TextStyle(
                color: Color(0xff29384D),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.email, size: 16.sp, color: Color(0xff29384D)),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          contact.email,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Color(0xff29384D),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 16.sp, color: Color(0xff29384D)),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          contact.phoneNumber,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Color(0xff29384D),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.call, color: Colors.green, size: 20),
                        onPressed: () {
                          makePhoneCall(contact.phoneNumber);
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 30.h,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text("Delete Contact"),
                                content: const Text(
                                  "Are you sure you want to delete this contact?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      onDelete();
                                    },
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        size: 14.sp,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF93E3E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
