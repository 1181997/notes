import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:notes/service_model/service_model.dart';
import 'base_model/note_class.dart';
import 'controllers/note_controller.dart';

class DetailScreen extends StatelessWidget {
  final Note note;
  DetailScreen({required this.note});

  final Rx<Color> selectedColor = Colors.white.obs;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: note.title);
    TextEditingController contentController =
        TextEditingController(text: note.content);

    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final updatedNote = Note(
                  id: note.id,
                  title: titleController.text,
                  content: contentController.text,
                  color: selectedColor.value,
                );

                NoteService.addOrUpdateNote(updatedNote);
                Get.back();
                Get.find<NoteController>().fetchNotes();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(
            () => IconButton(
                onPressed: () {
                  Get.find<NoteController>().toggleFavorite(note.id ?? 0);
                },
                icon: Icon(
                  note.isFavourite.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: note.isFavourite.value ? Colors.red : Colors.grey,
                )),
          ),
          IconButton(
            onPressed: () {
              NoteService.deleteNote(note.id);
              Get.back();
              Get.find<NoteController>().fetchNotes();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectColor(context);
        },
        child: Icon(Icons.color_lens),
      ),
    );
  }

  void _selectColor(BuildContext context) {
    Get.defaultDialog(
      title: 'Select Color',
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: selectedColor.value,
          onColorChanged: (Color color) {
            selectedColor.value = color;
          },
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            selectedColor.refresh();
            note.color = selectedColor.value;
            print(selectedColor.value);
            Navigator.of(context).pop();
          },
          child: Text('Select'),
        ),
      ],
    );
  }
}
