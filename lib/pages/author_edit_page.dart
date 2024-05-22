import 'package:bsi_mobile_app/common/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthorEditPage extends StatefulWidget {
  const AuthorEditPage({super.key, required this.author});
  final Map<String, dynamic> author;

  @override
  State<AuthorEditPage> createState() => _AuthorEditPageState();
}

class _AuthorEditPageState extends State<AuthorEditPage> {
  final nameController = TextEditingController();
  final dio = Dio();

  Map<String, dynamic> get mp => widget.author;

  // widget.author
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Author Add Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController..text = mp['name'],
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(
              onPressed: () {
                updteAuthor(mp['id']);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updteAuthor(int id) async {
    final response = await dio.post(
      '${Util.baseUrl}api/authors/$id?_method=PUT',
      data: {'name': nameController.text},
    );
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print(response.data);
      nameController.clear();
      var snackBar =
          const SnackBar(content: Text('Author successfully updated'));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
