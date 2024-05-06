import 'dart:convert';
import 'dart:io';

import 'package:contacts/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key, required this.id});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();

  final int id;
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    _fetchUserDetails();
    super.initState();
  }

  User? user;
  Future<void> _fetchUserDetails() async {
    try {
      Uri uri =
          Uri.parse("https://jsonplaceholder.typicode.com/users/${widget.id}");
      Response response = await get(uri);
      if (response.statusCode == 200) {
        String body = response.body;
        var json = jsonDecode(body);
        user = json
            .map<User>(
              (e) => fromJsonToUser(e),
            )
            .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
      if (e is SocketException) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: const [
          Icon(Icons.edit),
          Icon(Icons.star),
          Icon(Icons.more_vert),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LinearProgressIndicator(),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              height: MediaQuery.sizeOf(context).height / 5,
              child: const CircleAvatar(),
            ),
          ],
        ),
      ),
    );
  }
}
