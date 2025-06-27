import 'package:hive/hive.dart';

part 'contact_model.g.dart'; 

@HiveType(typeId: 0)
class ContactModel extends HiveObject {
  @HiveField(0)
  final String image;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phoneNumber;

  ContactModel({
    required this.image,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}
