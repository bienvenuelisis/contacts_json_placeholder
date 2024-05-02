import 'package:flutter/material.dart';

import 'screens/contacts_lists_screen.dart';

void main() {
  runApp(const ContactsApp());
}

class ContactsApp extends StatelessWidget {
  const ContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Contacts",
      home: ContactsList(),
    );
  }
}
