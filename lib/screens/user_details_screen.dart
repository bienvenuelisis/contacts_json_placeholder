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
      Uri uri = Uri.parse(
        "https://jsonplaceholder.typicode.com/users/${widget.id}",
      );
      Response response = await get(uri);
      if (response.statusCode == 200) {
        String body = response.body;
        var json = jsonDecode(body);

        user = fromJsonToUser(json);
        setState(() {});
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
        title: Text(user?.name ?? ""),
        actions: const [
          Icon(Icons.edit),
          Icon(Icons.star),
          Icon(Icons.more_vert),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (user == null) const LinearProgressIndicator(),
              if (user != null) ...[
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  height: MediaQuery.sizeOf(context).height / 5,
                  child: CircleAvatar(
                    child: Text(
                      user!.name[0],
                      style: const TextStyle(
                        fontSize: 45,
                      ),
                    ),
                  ),
                ),
                Text(
                  user!.name,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CardAction(icon: Icons.phone, label: "Call"),
                      CardAction(icon: Icons.sms, label: "Text"),
                      CardAction(icon: Icons.video_call, label: "Video"),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Contact Info'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(user!.phone),
                        subtitle: const Text("Mobile"),
                        trailing: const SizedBox(
                          width: 40,
                          child: Row(
                            children: [
                              Icon(Icons.video_call),
                              Icon(Icons.sms),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CardAction extends StatelessWidget {
  const CardAction({super.key, required this.icon, required this.label});

  final IconData icon;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.all(
              Radius.circular(45),
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        Text(label),
      ],
    );
  }
}
