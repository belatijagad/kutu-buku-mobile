import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kutubuku/utils/constants.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _chaptersController = TextEditingController();
  final TextEditingController _imgSrcController = TextEditingController();
  final TextEditingController _synopsisController = TextEditingController();
  // Assuming genres are entered as comma-separated values
  final TextEditingController _genresController = TextEditingController();

  Future<void> _submitBook() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    final bookData = {
      'title': _titleController.text,
      'chapters': int.tryParse(_chaptersController.text) ?? 0,
      'img_src': _imgSrcController.text,
      'synopsis': _synopsisController.text,
      'genre': _genresController.text,
    };

    // Replace with your API endpoint
    final request = context.read<CookieRequest>();
    final response =
        await request.postJson(Constants.addBook, jsonEncode(bookData));

    if (response['status'] == 'success') {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Berhasil menambahkan buku."),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Gagal."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _chaptersController,
                decoration: InputDecoration(labelText: 'Chapters'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number of chapters';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imgSrcController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _synopsisController,
                decoration: InputDecoration(labelText: 'Synopsis'),
                maxLines: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a synopsis';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genresController,
                decoration:
                    InputDecoration(labelText: 'Genres (comma-separated)'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter genres';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _submitBook,
                child: Text('Submit Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _chaptersController.dispose();
    _imgSrcController.dispose();
    _synopsisController.dispose();
    _genresController.dispose();
    super.dispose();
  }
}
