import 'package:flutter/material.dart';
import 'package:hive_clean_provider_bloc/core/components/bottom_sheet_component/bottom_sheet_component.dart';
import 'package:hive_clean_provider_bloc/core/components/dialog_component/custom_dialog.dart';
import 'package:hive_clean_provider_bloc/core/components/outlined_textfield.dart';
import 'package:hive_clean_provider_bloc/core/components/search_textfield.dart';
import 'package:hive_clean_provider_bloc/core/db/app_database.dart';
import 'package:hive_clean_provider_bloc/note_clean_provider/presentation/note_view_model.dart';
import 'package:provider/provider.dart';

import '../domain/entity/note/note.dart';

class NoteHiveCleanArcProvider extends StatefulWidget {
  const NoteHiveCleanArcProvider({super.key});

  @override
  State<NoteHiveCleanArcProvider> createState() =>
      _NoteHiveCleanArcProviderState();
}

class _NoteHiveCleanArcProviderState extends State<NoteHiveCleanArcProvider> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotes();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void getNotes() {
    context.read<NoteViewModel>().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Hive CleanArc Provider",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // if (context.watch<NoteViewModel>().list.length > 0)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: MySearchTextField(
                controller: searchController,
                labelText: "Search",
                prefixIcon: const Icon(Icons.search),
                callback: (value){
                 context.read<NoteViewModel>().searchInDb(value);
                },
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: context.watch<NoteViewModel>().list.length,
                itemBuilder: (context, index) {
                  Note note = context.watch<NoteViewModel>().list[index];
                  return listItem(context, index, note);
                }),
          ],
        ),
      ),
      floatingActionButton: createFloatingActionButtons(context, size),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     openBottomSheet(context, size);
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  void openBottomSheet(BuildContext context, Size size) {
    showModalBottomSheet(
        isScrollControlled: true, // to prevent cover bottomSheet by keyboard
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery // to prevent cover bottomSheet by keyboard
                        .of(context)
                    .viewInsets
                    .bottom),
            child: Container(
                width: size.width,
                height: 250,
                child: BottomSheetComponent(
                    callback: (String titleTF, String contentTF) {
                  addToDb(titleTF, contentTF, context);
                })),
          );
        });
  }

  void addToDb(String titleTF, String contentTF, BuildContext context) {
    Note note = Note(title: titleTF, content: contentTF);
    context.read<NoteViewModel>().addNote(note);
    // _noteViewModel.addNote(note);
  }

  Widget listItem(BuildContext context, int index, Note note) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.green.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.content),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  showEditDialog(context, note);
                },
                icon: const Icon(
                  Icons.edit,
                  size: 24,
                )),
            IconButton(
                onPressed: () {
                  context.read<NoteViewModel>().deleteNote(note);
                },
                icon: const Icon(Icons.delete, color: Colors.red, size: 24)),
          ],
        ),
      ),
    );
  }

  void showEditDialog(BuildContext context, Note note) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
              title: note.title,
              content: note.content,
              callback: (String titleTF, String contentTF) {
                note.title = titleTF;
                note.content = contentTF;

                context.read<NoteViewModel>().addNote(note);
              });
        });
  }

  Widget createFloatingActionButtons(BuildContext context, Size size) {
    return Container(
      width: size.width,
      height: 56,
      margin: const EdgeInsets.only(left: 30, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<NoteViewModel>().clearDB();
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              openBottomSheet(context, size);
            },
            child: const Icon(
              Icons.add,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
