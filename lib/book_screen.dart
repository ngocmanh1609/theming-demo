import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:theming_demo/book_model.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<BookModel> books = [];

  Brightness? currentBrightness;

  getBooks() async {
    try {
      final jsonData =
          await DefaultAssetBundle.of(context).loadString("assets/books.json");
      final Iterable parsedJson = jsonDecode(jsonData);
      List<BookModel> parsedBooks =
          List<BookModel>.from(parsedJson.map((e) => BookModel.fromJson(e)));
      setState(() {
        books = parsedBooks;
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Theming Demo'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(books[index].cover),
            title: Text(books[index].title),
            subtitle: Text(books[index].author),
            onTap: () => context.goNamed('detail', extra: books[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.light),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Tapped'),
            ));
          }),
    );
  }
}
