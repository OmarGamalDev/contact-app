import 'dart:io';
import 'package:contact_app/features/home/model/contact_model.dart';
import 'package:contact_app/features/home/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddContactBottomSheet extends StatefulWidget {
  final Function(ContactModel) onContactAdded;
  final BuildContext parentContext;

  const AddContactBottomSheet({
    super.key,
    required this.onContactAdded,
    required this.parentContext,
  });

  @override
  State<AddContactBottomSheet> createState() => _AddContactBottomSheetState();
}

class _AddContactBottomSheetState extends State<AddContactBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text("Missing Data"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff29384D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: 143.w,
                      height: 146.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff29384D),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0XFFFFF1D4),
                          width: 2,
                        ),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Name",
                          style: TextStyle(
                            color: Color(0XFFFFF1D4),
                            fontSize: 16.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "example@email.com",
                          style: TextStyle(
                            color: Color(0XFFFFF1D4),
                            fontSize: 16.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "+200000000000",
                          style: TextStyle(
                            color: Color(0XFFFFF1D4),
                            fontSize: 16.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                hintText: 'Enter User Name',
                keyboardType: TextInputType.name,
                controller: nameController,
              ),
              CustomTextField(
                hintText: 'Enter User Email',
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              CustomTextField(
                hintText: 'Enter User Phone',
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedImage == null ||
                        nameController.text.trim().isEmpty ||
                        emailController.text.trim().isEmpty ||
                        phoneController.text.trim().isEmpty) {
                      showErrorDialog(
                        "Please fill all fields and select an image.",
                      );
                      return;
                    }

                    final newContact = ContactModel(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      phoneNumber: phoneController.text.trim(),
                      image: selectedImage!.path,
                    );

                    widget.onContactAdded(newContact);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFF1D4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Enter user",
                    style: TextStyle(
                      color: const Color(0xff29384D),
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
