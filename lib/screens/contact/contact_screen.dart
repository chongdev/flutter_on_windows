import 'package:flutter/material.dart';
import 'package:flutter_on_windows/models/contact.dart';
import 'package:flutter_on_windows/screens/contact/new_contact.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late List<Contact> contacts = [];

  @override
  void initState() {
    cacheContact();

    super.initState();
  }

  Future<void> cacheContact() async {
    await Hive.openBox('contacts');
    debugPrint('-------------------> ${Hive.isAdapterRegistered(1)}');

    // final appDocDir = await path_provider.getApplicationDocumentsDirectory();
    if( !Hive.isAdapterRegistered(1) ){
      Hive.registerAdapter(ContactAdapter());
    }

    //
    // Hive.init(appDocDir.path);
    //
    // Hive.initFlutter(appDocDir.path);
    // debugPrint('-------------------> $contacts');
    // Contact contact = Contact(name: 'David',age: 12);
    // contacts.put('name', contact);
    // print('Name: ${contacts.get('name')}');
    // Hive.registerAdapter(0);
  }

  @override
  void dispose() {
    Hive.box('contacts').compact();
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final contactsBox = Hive.box('contacts');
    // var box = await Hive.openBox('testBox');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Hive NoSQL Database'),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: Hive.openBox('contacts'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Column(
                children: [
                  Expanded(child: _buildListView()),
                  const NewContactForm(),
                ],
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildListView() {
    // final contactsBox = Hive.box('contacts');
    // contacts.watch().listen((event) { })

    return WatchBoxBuilder(
      box: Hive.box('contacts'),
      builder: (context, contactsBox) {
        return ListView.builder(
          itemCount: contactsBox.length,
          itemBuilder: (context, index) {
            Contact contact = contactsBox.getAt(index) as Contact;

            return ListTile(
              title: Text(contact.name),
              subtitle: Text(contact.age.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => contactsBox.putAt(
                      index,
                      Contact(name: 'Name $index', age: index),
                    ),
                    icon: const Icon(Icons.refresh),
                  ),
                  IconButton(
                    onPressed: () => contactsBox.deleteAt(index),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
