import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final status = await Permission.phone.status;
  if (!status.isGranted) {
    await Permission.phone.request();
  }

  if (await Permission.phone.isGranted) {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }
}