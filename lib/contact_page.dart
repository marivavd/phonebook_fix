import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:phonebook/contact_edit.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  const ContactPage({super.key, required this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ContactEdit(
                  onSave: (){},
                  contact: widget.contact
                )
            )
          );
        },
      ),
      body: Column(
        children: [
          Stack(
            children: [
              (widget.contact.thumbnail != null)
                ? ClipRRect(child: Image.memory(widget.contact.photo!))
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        color: Theme.of(context).primaryColor,
                      ),
                      const Icon(Icons.person, size: 150)
                    ],
                  ) ,
              Positioned(
                top: 42,
                left: 12,
                child: IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Colors.white
                  )
                )
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const SizedBox(height: 22),
                Row(
                    children: [
                      const Text('Имя: ', style: TextStyle(fontSize: 20)),
                      Text(
                        widget.contact.name.last,
                        style: const TextStyle(fontSize: 20),
                      )
                    ]
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Фамилия: ', style: TextStyle(fontSize: 20)),
                    Text(
                      widget.contact.name.first,
                      style: const TextStyle(fontSize: 20),
                    )
                  ]
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Номер телефона: ', style: TextStyle(fontSize: 20)),
                    Text(
                      widget.contact.phones[0].number,
                      style: const TextStyle(fontSize: 20),
                    )
                  ]
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Комментарий: ', style: TextStyle(fontSize: 20)),
                    Text(
                       widget.contact.notes[0].note,
                      style: const TextStyle(fontSize: 20),
                    )
                  ]
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
