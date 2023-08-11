import 'package:flutter/material.dart';
import 'package:hive_clean_provider_bloc/core/components/outlined_textfield.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function callback;

  const CustomDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    titleController.text = title;
    contentController.text = content;

    Size size = MediaQuery.sizeOf(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: size.width,
        height: 250,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const  BoxDecoration(
            borderRadius:  BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            MyOutlinedTextField(controller: titleController, labelText: "Add title"),
            const SizedBox(
              height: 10,
            ),
            MyOutlinedTextField(
                controller: contentController, labelText: "Add Content"),
            const Spacer(),
            Container(
              height: 56,
              width: size.width,
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            callback(titleController.text, contentController.text);
                            Navigator.pop(context);
                          },
                          child: const Text("save"))),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("close")))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
