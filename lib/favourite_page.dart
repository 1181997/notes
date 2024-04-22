// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:notes/home_page.dart';
// import 'base_model/note_class.dart';
// import 'controllers/note_controller.dart';
// import 'detail_screen.dart';
//
// class FavoritePage extends StatelessWidget {
//   final NoteController noteController = Get.find();
//
//   FavoritePage({super.key});
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     List<Note> favoriteNotes = noteController.favoriteNotes
//         .where((note) => note.isFavourite.value) // Filter only favorite notes
//         .toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Notes'),
//         actions: [
//           IconButton(
//             icon: Obx(
//               () => Icon(Get.find<NoteController>().isAnyNoteSelected.value
//                   ? Icons.delete
//                   : null),
//             ),
//             onPressed: () {
//               noteController.deleteSelectedNotes();
//               noteController.isAnyNoteSelected.value = false;
//             },
//           ),
//           IconButton(
//             icon: Obx(
//               () => Icon(Get.find<NoteController>().isAnyNoteSelected.value
//                   ? Icons.favorite
//                   : null),
//             ),
//             onPressed: () {
//               noteController.toggleFavoriteSelectedNotes();
//               noteController.isAnyNoteSelected.value = false;
//             },
//           ),
//           IconButton(
//             icon: Obx(() => Icon(Get.find<NoteController>().isListView.value
//                 ? Icons.grid_view
//                 : Icons.list)),
//             onPressed: () {
//               Get.find<NoteController>().toggleView();
//             },
//           ),
//         ],
//       ),
//       body: Obx(
//         () => Get.find<NoteController>().isListView.value
//             ? ListView.builder(
//                 itemCount: favoriteNotes.length,
//                 itemBuilder: (context, index) {
//                   final note = favoriteNotes[index];
//                   return Obx(() => GestureDetector(
//                         onLongPress: () {
//                           Get.find<NoteController>()
//                               .toggleSelection(note.id ?? 0);
//                         },
//                         child: Card(
//                           color:
//                               note.isSelected.value ? Colors.grey : note.color,
//                           child: ListTile(
//                             title: Text(note.title),
//                             subtitle: Text(note.content),
//                             trailing: Obx(() => IconButton(
//                                   icon: Icon(
//                                     note.isFavourite.value
//                                         ? Icons.favorite
//                                         : Icons.favorite_border,
//                                     color: note.isFavourite.value
//                                         ? Colors.red
//                                         : Colors.grey,
//                                   ),
//                                   onPressed: () {
//                                     Get.find<NoteController>()
//                                         .toggleFavorite(note.id ?? 0);
//                                   },
//                                 )),
//                             onTap: () {
//                               if (noteController.isAnyNoteSelected.value) {
//                                 Get.find<NoteController>()
//                                     .toggleSelection(note.id ?? 0);
//                               } else {
//                                 Get.to(() => DetailScreen(note: note));
//                               }
//                             },
//                           ),
//                         ),
//                       ));
//                 },
//               )
//             : GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: favoriteNotes.length,
//                 itemBuilder: (context, index) {
//                   final note = favoriteNotes[index];
//                   return Obx(() => GestureDetector(
//                         onLongPress: () {
//                           Get.find<NoteController>()
//                               .toggleSelection(note.id ?? 0);
//                         },
//                         onTap: () {
//                           if (noteController.isAnyNoteSelected.value) {
//                             Get.find<NoteController>()
//                                 .toggleSelection(note.id ?? 0);
//                           } else {
//                             Get.to(() => DetailScreen(note: note));
//                           }
//                         },
//                         child: Card(
//                           color:
//                               note.isSelected.value ? Colors.grey : note.color,
//                           // color: note.color,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(note.title),
//                               SizedBox(height: 5),
//                               Text(note.content),
//                               Obx(
//                                 () => IconButton(
//                                   icon: Icon(
//                                     note.isFavourite.value
//                                         ? Icons.favorite
//                                         : Icons.favorite_border,
//                                     color: note.isFavourite.value
//                                         ? Colors.red
//                                         : Colors.grey,
//                                   ),
//                                   onPressed: () {
//                                     Get.find<NoteController>()
//                                         .toggleFavorite(note.id ?? 0);
//                                   },
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ));
//                 },
//               ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            icon: Obx(
                  () => Icon(Get.find<NoteController>().isAnyNoteSelected.value
                  ? Icons.delete
                  : null),
            ),
            onPressed: () {
              noteController.deleteSelectedNotes();
              noteController.isAnyNoteSelected.value = false;
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
            () {
          final favoriteNotes = noteController.favoriteNotes
              .where((note) => note.isFavourite.value)
              .toList();

          return Get.find<NoteController>().isListView.value
              ? ListView.builder(
            itemCount: favoriteNotes.length,
            itemBuilder: (context, index) {
              final note = favoriteNotes[index];
              return Obx(() => GestureDetector(
                onLongPress: () {
                  Get.find<NoteController>()
                      .toggleSelection(note.id ?? 0);
                },
                child: Card(
                  color: note.isSelected.value
                      ? Colors.grey
                      : note.color,
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: favoriteNotes.length,
            itemBuilder: (context, index) {
              final note = favoriteNotes[index];
              return Obx(() => GestureDetector(
                onLongPress: () {
                  Get.find<NoteController>()
                      .toggleSelection(note.id ?? 0);
                },
                onTap: () {
                  if (noteController.isAnyNoteSelected.value) {
                    Get.find<NoteController>()
                        .toggleSelection(note.id ?? 0);
                  } else {
                    Get.to(() => DetailScreen(note: note));
                  }
                },
                child: Card(
                  color: note.isSelected.value
                      ? Colors.grey
                      : note.color,
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
              ));
            },
          );
        },
      ),
    );
  }
}
