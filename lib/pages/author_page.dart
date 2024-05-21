import 'package:bsi_mobile_app/common/util.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'author_add_page.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({super.key});

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  List<Map<String, dynamic>> authorList = [];
  final dio = Dio();

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    final response = await dio.get('${Util.baseUrl}api/authors');
    if (response.statusCode == 200) {
      Map<String, dynamic> map = response.data;
      for (final m in map['data']) {
        authorList.add(m);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Author Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AuthorAddPage()));
            },
          ),
        ],
      ),
      body: ListView.builder(
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
