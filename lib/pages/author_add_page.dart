import 'package:bsi_mobile_app/common/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthorAddPage extends StatefulWidget {
  const AuthorAddPage({super.key});

  @override
  State<AuthorAddPage> createState() => _AuthorAddPageState();
}

class _AuthorAddPageState extends State<AuthorAddPage> {
  final nameController = TextEditingController();
  final dio = Dio();

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
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(
              onPressed: () {
                saveAuthor();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveAuthor() async {
    final response = await dio.post(
      '${Util.baseUrl}api/authors',
      data: {'name': nameController.text},
    );
    if (response.statusCode == 201) {
      // ignore: avoid_print
      print(response.data);
      nameController.clear();
      var snackBar =
          const SnackBar(content: Text('Author successfully created'));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
