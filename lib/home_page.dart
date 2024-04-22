import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_model/note_class.dart';
import 'controllers/note_controller.dart';
import 'detail_screen.dart';

class HomePage extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());
  bool isListView = true;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(Get.find<NoteController>().isAnyNoteSelected.value
                  ? Icons.delete
                  : null),
            ),
            onPressed: () {
              noteController.deleteSelectedNotes();
              noteController.isAnyNoteSelected.value = false;
              noteController.fetchNotes();
            },
          ),
          IconButton(
            icon: Obx(
              () => Icon(Get.find<NoteController>().isAnyNoteSelected.value
                  ? Icons.favorite
                  : null),
            ),
            onPressed: () {

              noteController.toggleFavoriteSelectedNotes();
              noteController.isAnyNoteSelected.value = false;
              noteController.fetchNotes();
            },
          ),
          IconButton(
            icon: Obx(() => Icon(Get.find<NoteController>().isListView.value
                ? Icons.grid_view
                : Icons.list)),
            onPressed: () {
              Get.find<NoteController>().toggleView();
            },
          ),
        ],
      ),
      body: Obx(
        () => Get.find<NoteController>().isListView.value
            ? ListView.builder(
                itemCount: noteController.notes.length,
                itemBuilder: (context, index) {
                  final note = noteController.notes[index];
                  return Obx(() => GestureDetector(
                        onLongPress: () {
                          print("press");
                          Get.find<NoteController>()
                              .toggleSelection(note.id ?? 0);
                        },
                        child: Card(
                          color:
                              note.isSelected.value ? Colors.grey : note.color,
                          // color: note.color,
                          child: ListTile(
                            title: Text(note.title),
                            subtitle: Text(note.content),
                            trailing: Obx(() => IconButton(
                                  icon: Icon(
                                    note.isFavourite.value
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: note.isFavourite.value
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    Get.find<NoteController>()
                                        .toggleFavorite(note.id ?? 0);
                                  },
                                )),
                            onTap: () {
                              if (noteController.isAnyNoteSelected.value) {
                                Get.find<NoteController>()
                                    .toggleSelection(note.id ?? 0);
                              } else {
                                Get.to(() => DetailScreen(note: note));
                              }
                            },
                          ),
                        ),
                      ));
                },
              )
            : GridView.builder(
                itemCount: noteController.notes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final note = noteController.notes[index];
                  return Obx(() => GestureDetector(
                        onLongPress: () {
                          Get.find<NoteController>()
                              .toggleSelection(note.id ?? 0);
                        },
                        child: Card(
                          color:
                              note.isSelected.value ? Colors.grey : note.color,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(note.title),
                              SizedBox(
                                height: 10,
                              ),
                              Text(note.content),
                              Obx(
                                () => IconButton(
                                  icon: Icon(
                                    note.isFavourite.value
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: note.isFavourite.value
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    Get.find<NoteController>()
                                        .toggleFavorite(note.id ?? 0);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          if (noteController.isAnyNoteSelected.value) {
                            Get.find<NoteController>()
                                .toggleSelection(note.id ?? 0);
                          } else {
                            Get.to(() => DetailScreen(note: note));
                          }
                        },
                      ));
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => DetailScreen(note: Note.empty()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
