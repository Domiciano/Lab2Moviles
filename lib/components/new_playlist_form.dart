import 'package:flutter/material.dart';

class NewPlaylistForm extends StatefulWidget {
  final void Function(String, String) onSubmit;

  const NewPlaylistForm({super.key, required this.onSubmit});

  @override
  State<NewPlaylistForm> createState() => _NewPlaylistFormState();
}

class _NewPlaylistFormState extends State<NewPlaylistForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "Playlist Name"),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: "Description"),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onSubmit(
                _nameController.text,
                _descriptionController.text,
              );
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }
}
