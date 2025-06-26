import 'dart:io';
import 'package:contact_app/features/home/model/contact_model.dart';
import 'package:contact_app/features/home/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddContactBottomSheet extends StatefulWidget {
  final Function(ContactModel) onContactAdded;
  const AddContactBottomSheet({super.key, required this.onContactAdded});
  @override
  State<AddContactBottomSheet> createState() => _AddContactBottomSheetState();
}

class _AddContactBottomSheetState extends State<AddContactBottomSheet> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  File? selectedImage;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff29384D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xff29384D),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: 143.w,
                      height: 146.h,
                      decoration: BoxDecoration(
                        color: Color(0xff29384D),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0XFFFFF1D4), width: 2),
                      ),
                      child:
                          selectedImage != null
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : Center(
                                child: Image.asset(
                                  "assets/images/add_photo.png",
                                  width: 124.w,
                                  height: 124.h,
                                ),
                              ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Name",
                        style: TextStyle(
                          color: Color(0XFFFFF1D4),
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "example@email.com",
                        style: TextStyle(
                          color: Color(0XFFFFF1D4),
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "+200000000000",
                        style: TextStyle(
                          color: Color(0XFFFFF1D4),
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              hintText: 'Enter User Name ',
              keyboardType: TextInputType.name,
              controller: nameController,
            ),
            CustomTextField(
              hintText: 'Enter User Email ',
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            CustomTextField(
              hintText: 'Enter User Phone',
              keyboardType: TextInputType.phone,
              controller: phoneController,
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  final newContact = ContactModel(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    phoneNumber: phoneController.text.trim(),
                    image: selectedImage?.path ?? '',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFFF1D4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Enter user",
                  style: TextStyle(color: Color(0xff29384D), fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
