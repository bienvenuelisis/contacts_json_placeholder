import 'dart:convert';

import 'package:contacts/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  void initState() {
    debugPrint("Before init state");
    fetchUsers();
    super.initState();
  }

  List<User>? users;

  Future<void> fetchUsers() async {
    try {
      Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/users");
      debugPrint("Before get users");
      Response response = await get(uri);
      debugPrint(" after get  users");
      if (response.statusCode == 200) {
        users = jsonDecode(response.body)
            .map<User>((e) => fromJsonToUser(e))
            .toList();
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("widget is rebuilding");
    return Material(
      color: Colors.grey[100],
      child: users == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: (users!.length),
              itemBuilder: (context, index) {
                final user = users![index];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(user.id.toString()),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    icon: const Icon(Icons.phone),
                    onPressed: () {},
                  ),
                );
              },
            ),
    );
  }
}
