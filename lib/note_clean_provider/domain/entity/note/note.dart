
import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject{

  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  Note({required this.title, required this.content});
}
// first add   part 'note.g.dart';
// then run this command in terminal: "flutter packages pub run build_runner build"