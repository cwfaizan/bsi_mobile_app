import 'package:bsi_mobile_app/common/util.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'author_add_page.dart';
import 'author_edit_page.dart';

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
    authorList.clear();
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuthorAddPage()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: authorList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/c/c6/SearsHouse115.jpg",
              ),
            ),
            title: Text(authorList[index]['name']),
            subtitle: Text(authorList[index]['created_at']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthorEditPage(
                          author: authorList[index],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete'),
                            content: const Text('Are you sure?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Delete'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  deleteAuthor(authorList[index]['id']);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> deleteAuthor(int id) async {
    final response = await dio.delete('${Util.baseUrl}api/authors/$id');
    if (response.statusCode == 200) {
      initData();
      var snackBar =
          const SnackBar(content: Text('Author successfully deleted'));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
