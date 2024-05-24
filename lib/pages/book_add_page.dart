import 'package:bsi_mobile_app/models/category.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BookAddPage extends StatefulWidget {
  const BookAddPage({super.key});

  @override
  State<BookAddPage> createState() => _BookAddPageState();
}

class _BookAddPageState extends State<BookAddPage> {
  final dio = Dio();
  Category? selectedCategory;
  List<DropdownMenuItem<Category>> itemList = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    itemList.clear();
    final response = await dio.get('https://email.nsdd.cloud/api/categories');
    if (response.statusCode == 200) {
      Map<String, dynamic> map = response.data;

      for (Map<String, dynamic> mp in (map['data'])) {
        Category category = Category.fromJson(mp);
        DropdownMenuItem<Category> value = DropdownMenuItem(
          value: category,
          child: Text(category.name),
        );
        itemList.add(value);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),
      body: Column(
        children: [
          DropdownButton<Category>(
            items: itemList,
            value: selectedCategory,
            onChanged: (newValue) {
              selectedCategory = newValue;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
