import 'package:flutter/material.dart';
import 'package:hive_clean_provider_bloc/core/components/outlined_textfield.dart';

class BottomSheetComponent extends StatelessWidget {
  final Function callback;

  const BottomSheetComponent({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          MyOutlinedTextField(controller: titleController, hint: "Add title"),
          const SizedBox(
            height: 10,
          ),
          MyOutlinedTextField(
              controller: contentController, hint: "Add Content"),
          const Spacer(),
          Container(
            width: size.width,
            height: 56,
            margin:const  EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    callback(titleController.text, contentController.text);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: const Text(
                    "Add item",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
