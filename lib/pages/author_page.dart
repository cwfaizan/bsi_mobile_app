import 'package:flutter/material.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({super.key});

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  List<Map<String, dynamic>> authorList = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    authorList = [
      {
        'id': 1,
        'name': 'John Doe',
        'created_at': '2022-01-01 00:00:00',
      },
      {
        'id': 2,
        'name': 'Jane Doe',
        'created_at': '2022-01-02 00:00:00',
      },
      {
        'id': 3,
        'name': 'John Smith',
        'created_at': '2022-01-03 00:00:00',
      },
      {
        'id': 4,
        'name': 'John Smith',
        'created_at': '2022-01-03 00:00:00',
      },
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Author Page'),
      ),
      body: ListView.builder(
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 2,
        // ),
        itemCount: authorList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(authorList[index]['id'].toString()),
            ),
            title: Text(authorList[index]['name']),
            subtitle: Text(authorList[index]['created_at']),
          );
        },
      ),
    );
  }
}
