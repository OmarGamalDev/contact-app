import 'package:contact_app/features/home/model/contact_model.dart';
import 'package:contact_app/features/home/widgets/add_contact_bottom_sheet.dart';
import 'package:contact_app/features/home/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routename = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactModel> contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff29384D),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: const Color(0xffF93E3E),
            child: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                contacts.clear();
              });
            },
          ),
          SizedBox(height: 10.h),
          FloatingActionButton(
            backgroundColor: const Color(0xffFFF1D4),
            child: const Icon(Icons.add),
            onPressed: () {
              final parentContext = context;
              showModalBottomSheet(
                context: parentContext,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder:
                    (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: AddContactBottomSheet(
                        onContactAdded: (contact) {
                          setState(() {
                            contacts.add(contact);
                          });
                        },
                        parentContext: parentContext,
                      ),
                    ),
              );
            },
          ),
        ],
      ),
      body:
          contacts.isEmpty
              ? Center(
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
              )
              : Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  itemCount: contacts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.05,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder:
                      (context, index) => ContactCard(
                        contact: contacts[index],
                        onDelete: () {
                          setState(() {
                            contacts.removeAt(index);
                          });
                        },
                      ),
                ),
              ),
    );
  }
}
