import 'package:contact_app/features/home/widgets/add_contact_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder:
              (context) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddContactBottomSheet(),
              ),
        );
      },
      backgroundColor: Color(0xffFFF1D4),
      child: Icon(Icons.add, size: 30.0),
    );
  }
}
