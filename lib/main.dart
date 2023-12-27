import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:phonebook/contact_page.dart';
import 'package:phonebook/contact_edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phonebook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Contact> contacts = [];
  bool isGet = false;

  @override
  void initState() {
    super.initState();
    init().then((value) => null);
  }

  Future<void> init() async {
    await refreshContacts();
    FlutterNativeSplash.remove();
    if (!isGet) {
      var value = await Permission.contacts.request();
      if (value.isGranted) {
        refreshContacts();
      } else {
        setState(() {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Denied')));
        });
      }
    }
  }

  Future<void> refreshContacts() async {
    if (await Permission.contacts.isGranted) {
      var newContacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true, withAccounts: true
      );
      setState(() {
        contacts = newContacts;
        isGet = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                  ContactPage(
                    contact: Contact()
                  )
              )
            );
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 42),
            const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                "Контакты",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  var contact = contacts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                  ContactPage(contact: contact)
                              )
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                                child: (contact.thumbnail != null)
                                    ? ClipRRect(borderRadius: BorderRadius.circular(30),child: Image.memory(contact.thumbnail!))
                                    : const Icon(Icons.person)),
                            const SizedBox(width: 22),
                            Text(contact.displayName,  style: const TextStyle(fontSize: 24)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      contact
                                          .delete()
                                          .then((value) => refreshContacts());
                                    });
                                  },
                                ),
                              )
                            )
                        ]
                      )
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 1, width: double.infinity, color: Colors.grey
                  );
                }
              ),
            ),
          ],
        ));
  }
}
