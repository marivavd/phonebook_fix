import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactEdit extends StatefulWidget {
  late Contact contact;
  final Function onSave;
  bool isNew = false;

  ContactEdit({super.key, Contact? contact, required this.onSave}){
    if (contact == null){
      this.contact = Contact();
      isNew = true;
    }else{
      this.contact = contact!;
    }
  }

  @override
  State<ContactEdit> createState() => _ContactEditState();
}
class _ContactEditState extends State<ContactEdit> {
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isNew == false){
    firstNameController.text = widget.contact.name.first;
    lastNameController.text = widget.contact.name.last;
    if (widget.contact.phones.isNotEmpty){
      phoneController.text = widget.contact.phones[0].number;
    }
    if (widget.contact.notes.isNotEmpty){
    commentController.text = widget.contact.notes[0].note;}}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    fixedSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    side: BorderSide.none
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16, color: Colors.black)
                )
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: const Size.fromHeight(50),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)
                    )
                ),
                onPressed: () async {
                  if (widget.isNew){
                    await widget.contact.insert();

                  }else{
                    await widget.contact.update();
                  }
                  setState(() {
                    widget.onSave();
                    Navigator.of(context).pop();
                  });
                },
                child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 16, color: Colors.black)
                )
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          const SizedBox(height: 100),
          getTextField( firstNameController, "Имя", (text) => widget.contact.name.first = text, TextInputType.name, 1),
          const SizedBox(height: 10),
          getTextField(lastNameController, "Фамилия", (text) => widget.contact.name.last = text, TextInputType.name, 1),
          const SizedBox(height: 10),
          getTextField(phoneController, "Номер телефона", (text) =>
          {if (widget.contact.phones.isNotEmpty){
            widget.contact.phones.first.number = text
          }
          else{
              widget.contact.phones.add(Phone(text))
          }}, TextInputType.number, 1),
          const SizedBox(height: 10),
          getTextField(commentController, "Комментарий", (text) =>
          {if (widget.contact.notes.isNotEmpty){
            widget.contact.notes.first.note = text
          }
          else{
              widget.contact.notes.add(Note(text))
            }}, TextInputType.text, 4),
        ]),
      ),
    );
  }

  Widget getTextField(
    TextEditingController controller,
    String hint,
    Function(String) onChanged,
    TextInputType type,
    int maxLines
  ){
    return TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        onChanged: onChanged,
        keyboardType: type,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              width: 1,
              style: BorderStyle.none,
            ),
          ),
        )
    );
  }
}