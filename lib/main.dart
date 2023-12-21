import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:phonebook/contact_form_adding.dart';
import 'package:phonebook/contact_page.dart';
import 'package:phonebook/contact_edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phonebook',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Phonebook'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

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

  Future<void> init() async{
    await refreshContacts;
    FlutterNativeSplash.remove();
    if (!isGet){
      var value = await Permission.contacts.request();
      if (value.isGranted){
        refreshContacts();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Denied')));
      }
    }
  }

  Future<void> refreshContacts() async{
    if (await Permission.contacts.isGranted) {
      var newContacts = await FlutterContacts.getContacts(
        withProperties: true, withPhoto: true, withAccounts: true);
      setState(() {
        contacts = newContacts;
        isGet = true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact_Form(
              onSave: (){refreshContacts();})
          )
          );
        },
      ),
        backgroundColor: Color.fromARGB(255, 167, 220, 204),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
              width: double.infinity,
              child: ListView.separated(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  var contact = contacts[index];
                  return GestureDetector(
                    onTap: ()
                    {Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Contact_Page(contact: contact)));},
                      child: Row(children: [
                        CircleAvatar(
                            child: (contact.thumbnail != null) ?
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.memory(contact.thumbnail!)):
                            const Icon(Icons.person)),
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(contact.displayName,
                                style: TextStyle(fontSize: 24))),
                        Expanded(
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact_Edit(
                                    contact: contact, onSave: (){refreshContacts();})
                                )
                                );
                              },
                            )),
                        Expanded(
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {contact.delete().then((value) => refreshContacts());});
                              },
                            ))
                      ]));
                  },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 2, width: double.infinity, color: Colors.black);
                },
                physics: const BouncingScrollPhysics(),
              )),
        ));
  }
}
