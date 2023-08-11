
import 'package:hive/hive.dart';
part 'contact.g.dart';
@HiveType(typeId: 1)
class Contact extends HiveObject{

  @HiveField(0)
  late String name;

  @HiveField(1)
  late int phone;

  Contact({required this.name, required this.phone});
}

// first add   part 'person.g.dart';
// then run this command in terminal: "flutter packages pub run build_runner build"