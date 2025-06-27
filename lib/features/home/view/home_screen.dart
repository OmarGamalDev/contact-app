import 'package:contact_app/features/home/model/contact_model.dart';
import 'package:contact_app/features/home/widgets/add_contact_bottom_sheet.dart';
import 'package:contact_app/features/home/widgets/contact_card.dart';
import 'package:contact_app/features/home/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactModel> allContacts = [];
  List<ContactModel> contacts = [];
  late Box<ContactModel> contactsBox;
  late TextEditingController searchController;
  String currentSearchQuery = '';

  @override
  void initState() {
    super.initState();
    contactsBox = Hive.box<ContactModel>('contactsBox');
    searchController = TextEditingController();

    loadContacts();
  }

  void loadContacts() {
    allContacts = contactsBox.values.toList();

    if (currentSearchQuery.trim().isEmpty) {
      contacts = List.from(allContacts);
    } else {
      contacts =
          allContacts.where((contact) {
            return contact.name.toLowerCase().contains(
              currentSearchQuery.toLowerCase(),
            );
          }).toList();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void addContact(ContactModel contact) {
    contactsBox.add(contact);
    setState(() {
      loadContacts();
    });
  }

  void deleteContact(int index) {
    final deletedContact = contacts[index];
    deletedContact.delete();
    setState(() {
      loadContacts();
    });
  }

  void clearContacts() {
    contactsBox.clear();
    setState(() {
      allContacts.clear();
      contacts.clear();
      searchController.clear();
      currentSearchQuery = '';
    });
  }

  void showAddContactBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => AddContactBottomSheet(
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40.h, left: 16.w, right: 16.w),
          child: TextField(
            controller: searchController,
            onChanged: (query) {
              setState(() {
                currentSearchQuery = query;
                loadContacts();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search Contact',
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: GridView.builder(
              itemCount: contacts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.62,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
              ),
              itemBuilder:
                  (context, index) => ContactCard(
                    contact: contacts[index],
                    onDelete: () => deleteContact(index),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
