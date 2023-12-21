import 'package:flutter/material.dart';
import 'package:phonebook/contact_edit.dart';
import 'package:flutter_contacts/flutter_contacts.dart';


class Contact_Page extends StatefulWidget {
  final Contact contact;


  const Contact_Page({super.key, required this.contact});

  @override
  State<Contact_Page> createState() => _Contact_PageState();
}
class _Contact_PageState extends State<Contact_Page> {



    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 167, 220, 204),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: (widget.contact.thumbnail != null) ?
              ClipRRect(
                  child: Image.memory(widget.contact.thumbnail!)):
                  Image.asset("assets/raccoon.jpg"),),
              Column(
                children: [
                  SizedBox(child:Row(children: [Text('Имя: ', style: TextStyle(fontSize: 20)), Text(widget.contact.name.first, style: TextStyle(fontSize: 20),)])),
                  SizedBox(child:Row(children: [Text('Фамилия: ', style: TextStyle(fontSize: 20)), Text(widget.contact.name.last, style: TextStyle(fontSize: 20),)])),
                  SizedBox(child:Row(children: [Text('Номер телефона: ', style: TextStyle(fontSize: 20)), Text(widget.contact.phones.first.number, style: TextStyle(fontSize: 20),)])),
                  SizedBox(child:Row(children: [Text('Почта: ', style: TextStyle(fontSize: 20)), Text(widget.contact.emails.first.address, style: TextStyle(fontSize: 20),)])),],)

            ],
          ),
        )
      ),
    );
  }
}