import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class Contact_Edit extends StatefulWidget {
  final Contact contact;
  final Function onSave;


  const Contact_Edit({super.key, required this.contact, required this.onSave});

  @override
  State<Contact_Edit> createState() => _Contact_EditState();
}
class _Contact_EditState extends State<Contact_Edit> {
  late TextEditingController name;
  late TextEditingController surname;
  late TextEditingController phone;
  late TextEditingController email;


  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.contact.name.first);
    surname = TextEditingController(text: widget.contact.name.last);
    phone = TextEditingController(text: widget.contact.phones.first.number);
    email = TextEditingController(text: widget.contact.emails.first.address);
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 167, 220, 204),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          SizedBox(height: 100),
          TextField(
              controller: name,
              style: TextStyle(color: Colors.black, decorationThickness: 3),
              onChanged: (text)
              {widget.contact.name.first = text;},
              decoration: InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(fontSize: 16),
                fillColor: Color.fromARGB(255, 169, 169, 169),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 5,
                    style: BorderStyle.none,
                  ),
                ),
              )
          ),
          SizedBox(height: 10),
          TextField(
              controller: surname,
              style: TextStyle(color: Colors.black, decorationThickness: 0),
              onChanged: (text)
              {widget.contact.name.last = text;},
              decoration: InputDecoration(
                hintText: "Surname",
                hintStyle: TextStyle(fontSize: 16),
                fillColor: Color.fromARGB(255, 169, 169, 169),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 5, style: BorderStyle.none,),
                ),
              )
          ),
          SizedBox(height: 10),
          TextField(
              onChanged: (text)
              {widget.contact.phones.first.number = text;},
              controller: phone,
              style: TextStyle(color: Colors.black, decorationThickness: 0),
              decoration: InputDecoration(
                hintText: "Phone number",
                hintStyle: TextStyle(fontSize: 16),
                fillColor: Color.fromARGB(255, 169, 169, 169),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 5, style: BorderStyle.none,),
                ),
              )
          ),
          SizedBox(height: 10),
          TextField(
              onChanged: (text)
              {widget.contact.emails.first.address = text;},
              controller: email,
              style: TextStyle(color: Colors.black, decorationThickness: 0),
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(fontSize: 16),
                fillColor: Color.fromARGB(255, 169, 169, 169),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 5, style: BorderStyle.none,),
                ),
              )
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: OutlinedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel', style: TextStyle(fontSize: 20, color: Colors.black))),),
              SizedBox(width: 40,),
              Expanded(
                child: OutlinedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),),
                    onPressed: () async {
                      await widget.contact.update();
                      setState(() {
                        widget.onSave();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('save')));
                      });
                    },
                    child: Text("Save", style: TextStyle(fontSize: 20, color: Colors.black),)),)
            ],
          )

        ]),
      ),
    );
  }
}