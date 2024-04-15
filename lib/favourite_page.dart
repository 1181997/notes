import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'controllers/note_controller.dart';
import 'detail_screen.dart';

class FavoritePage extends StatelessWidget {
  final NoteController noteController = Get.find();

  FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Notes'),
        actions: [
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
                itemCount: noteController.favoriteNotes.length,
                itemBuilder: (context, index) {
                  final note = noteController.favoriteNotes[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    tileColor: note.color,
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
                      Get.to(() => DetailScreen(note: note));
                    },
                  );
                },
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: noteController.favoriteNotes.length,
                itemBuilder: (context, index) {
                  final note = noteController.favoriteNotes[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailScreen(note: note));
                    },
                    child: Card(
                      color: note.color,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(note.title),
                          SizedBox(height: 5),
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
                  );
                },
              ),
      ),
    );
  }
}
