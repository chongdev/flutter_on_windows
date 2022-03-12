import 'package:flutter/material.dart';
import 'package:flutter_on_windows/models/contact.dart';
import 'package:hive/hive.dart';

class NewContactForm extends StatefulWidget {
  const NewContactForm({Key? key}) : super(key: key);

  @override
  State<NewContactForm> createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _age;

  void addContact(Contact contact) {
    debugPrint('Name: ${contact.name}, Age: ${contact.age}');
    Hive.box('contacts').add(contact);


    _name = '';
    _age = '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value!,
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Age'),
                  onSaved: (value) => _age = value!,
                ),
              ),
            ],
          ),

          RaisedButton(
            child: const Text('Add New Contact'),
              onPressed: (){
              _formKey.currentState?.save();
              final newContact = Contact(name: _name,age: int.parse(_age));
              addContact(newContact);
            },
          )
        ],
      ),
    );
  }
}
