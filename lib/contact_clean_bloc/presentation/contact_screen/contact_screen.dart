import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_clean_provider_bloc/contact_clean_bloc/domain/entity/contact.dart';
import 'package:hive_clean_provider_bloc/contact_clean_bloc/presentation/bloc/contact_cubit.dart';
import 'package:hive_clean_provider_bloc/di.dart';

import '../../../core/components/bottom_sheet_component/bottom_sheet_component.dart';
import '../../../core/components/dialog_component/custom_dialog.dart';
import '../../../core/components/search_textfield.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ContactCubit(sl())),
      ],
      child: const IContactScreen(),
    );
  }
}

class IContactScreen extends StatefulWidget {
  const IContactScreen({super.key});

  @override
  State<IContactScreen> createState() => _IContactScreenState();
}

class _IContactScreenState extends State<IContactScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ContactCubit>().getContacts(null);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hive CleanArc Bloc",
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: MySearchTextField(
                controller: searchController,
                labelText: "Search",
                prefixIcon: const Icon(Icons.search),
                callback: (value) {
                  context.read<ContactCubit>().getContacts(value);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<ContactCubit, ContactState>(
                builder: (context, state) {
                  if (state is ContactLoaded) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.list.length,
                        itemBuilder: (context, index) {
                          Contact contact = state.list[index];
                          return listItem(context, index, contact);
                        });
                  } else {
                    return Container();
                  }
                },
                listener: (context, state) {}),
          ],
        ),
      ),
      floatingActionButton: createFloatingActionButtons(context, size),
    );
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
              context.read<ContactCubit>().clearDB();
              // context.read<ContactCubit>().getContacts(null);
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
                    callback: (String nameTF, String phoneTF) {
                  int phone = int.parse(phoneTF);
                  addToDb(nameTF, phone);
                })),
          );
        });
  }

  void addToDb(String titleTF, int contentTF) {
    Contact contact = Contact(name: titleTF, phone: contentTF);
    context.read<ContactCubit>().addContact(contact);
    // _noteViewModel.addNote(note);
  }

  Widget listItem(BuildContext context, int index, Contact contact) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.green.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: ListTile(
        title: Text(contact.name),
        subtitle: Text(contact.phone.toString()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  showEditDialog(contact);
                },
                icon: const Icon(
                  Icons.edit,
                  size: 24,
                )),
            IconButton(
                onPressed: () {
                  context.read<ContactCubit>().deleteContact(contact);
                },
                icon: const Icon(Icons.delete, color: Colors.red, size: 24)),
          ],
        ),
      ),
    );
  }

  void showEditDialog(Contact contact) {
    showDialog(
        context: context,
        builder: (BuildContext context1) {
          return CustomDialog(
              title: contact.name,
              content: contact.phone.toString(),
              callback: (String nameTF, String phoneTF) {
                contact.name = nameTF;
                contact.phone = int.parse(phoneTF);

                context.read<ContactCubit>().addContact(contact);
              });
        });
  }
}
