import 'package:contact_app/features/home/model/contact_model.dart';
import 'package:contact_app/features/home/widgets/add_contact_bottom_sheet.dart';
import 'package:contact_app/features/home/widgets/contact_card.dart';
import 'package:contact_app/features/home/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ContactModel> contacts = [];

  void addContact(ContactModel contact) {
    setState(() => contacts.add(contact));
  }

  void deleteContact(int index) {
    setState(() => contacts.removeAt(index));
  }

  void clearContacts() {
    setState(() => contacts.clear());
  }

  void showAddContactBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddContactBottomSheet(
        onContactAdded: addContact,
        parentContext: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff29384D),
      floatingActionButton: CustomFloatingActionButton(
        onAddPressed: showAddContactBottomSheet,
        onClearPressed: clearContacts,
      ),
      body: contacts.isEmpty ? buildEmptyState() : buildContactGrid(),
    );
  }

  Widget buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/contact_image.png',
            fit: BoxFit.cover,
            width: 368.w,
            height: 368.h,
          ),
          SizedBox(height: 16.h),
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
    );
  }

  Widget buildContactGrid() {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: GridView.builder(
        itemCount: contacts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.62,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
        ),
        itemBuilder: (context, index) => ContactCard(
          contact: contacts[index],
          onDelete: () => deleteContact(index),
        ),
      ),
    );
  }
}