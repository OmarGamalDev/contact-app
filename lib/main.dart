import 'package:contact_app/features/home/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/constants/routes.dart';
import 'features/home/view/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactModelAdapter()); 
  await Hive.openBox<ContactModel>('contactsBox');
  runApp(const ContactApp());
}

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: onGenerateRoute,
          initialRoute: HomeScreen.routeName,
        );
      },
    );
  }
}
