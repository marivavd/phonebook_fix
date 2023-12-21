import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class Contact_Form extends StatefulWidget {
  late final Contact contact;
  final Function onSave;


  Contact_Form({super.key, Contact? contact, required this.onSave}){
      this.contact = Contact();
  }
  @override
  State<Contact_Form> createState() => _Contact_FormState();
}
class _Contact_FormState extends State<Contact_Form> {

  @override
  void initState() {
    super.initState();
    widget.contact.phones = [];
    widget.contact.emails = [];

  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 167, 220, 204),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          SizedBox(height: 100),
          TextField(
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
              {if (widget.contact.phones.isEmpty){
                widget.contact.phones.add(Phone(text));
              }
              else{
                widget.contact.phones[0] = Phone(text);
              }
              },
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
              {if (widget.contact.emails.isEmpty){
                widget.contact.emails.add(Email(text));
              }
              else{
                widget.contact.emails[0] = Email(text);
              }
              },
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
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                    ),
                    onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: TextStyle(fontSize: 20, color: Colors.black))),),
              SizedBox(width: 40,),
              Expanded(
                child: OutlinedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),),
                  onPressed: () async {
                    await widget.contact.insert();
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
