import 'dart:io';
import 'package:contact_app/features/home/model/contact_model.dart';
import 'package:contact_app/features/home/utils/constant_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onDelete;

  const ContactCard({super.key, required this.contact, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 177.w,
      decoration: _buildCardDecoration(),
      child: Column(
        children: [
          _buildContactImage(),
          _buildContactName(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEmailRow(),
                  SizedBox(height: 4.h),
                  _buildPhoneRow(context),
                  const Spacer(),
                  _buildDeleteButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: const Color(0xffFFF1D4),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 6,
          offset: const Offset(2, 4),
        ),
      ],
    );
  }

  Widget _buildContactImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Image.file(
        File(contact.image),
        height: 130.h,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContactName() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Text(
        contact.name,
        style: TextStyle(
          color: const Color(0xff29384D),
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildEmailRow() {
    return Row(
      children: [
        Icon(Icons.email, size: 18.sp, color: const Color(0xff29384D)),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            contact.email,
            style: TextStyle(fontSize: 15.sp, color: const Color(0xff29384D)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneRow(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.phone, size: 18.sp, color: const Color(0xff29384D)),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            contact.phoneNumber,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xff29384D),
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.call, color: Colors.green, size: 18),
          onPressed: () => makePhoneCall(contact.phoneNumber),
        ),
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30.h,
      child: ElevatedButton.icon(
        onPressed: () => _showDeleteConfirmationDialog(context),
        icon: Icon(Icons.delete, size: 14.sp, color: Colors.white),
        label: Text(
          "Delete",
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffF93E3E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
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
                onPressed: () => Navigator.of(context).pop(),
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
  }
}
