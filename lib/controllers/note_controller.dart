import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../base_model/note_class.dart';
import '../service_model/service_model.dart';

class NoteController extends GetxController {
  var notes = RxList<Note>();
  var isLoading = true.obs;
  RxBool isListView = true.obs;
  RxList<int> selectedNotes = <int>[].obs;
  final RxBool isAnyNoteSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  void fetchNotes() async {
    print("success");
    try {
      isLoading(true);
      var fetchedNotes = await NoteService.fetchNotes();
      notes.assignAll(fetchedNotes);
    } finally {
      isLoading(false);
    }
  }

  void toggleView() {
    isListView.value = !isListView.value;
  }

  void toggleFavorite(int noteId) {
    final note = notes.firstWhere((note) => note.id == noteId);
    note.isFavourite.value = !note.isFavourite.value;
    NoteService.addOrUpdateNote(note);
  }

  List<Note> get favoriteNotes =>
      notes.where((note) => note.isFavourite.value).toList();

  void toggleSelection(int noteId) {
    print(noteId);
    final noteIndex = notes.indexWhere((note) => note.id == noteId);
    if (noteIndex != -1) {
      notes[noteIndex].isSelected.toggle();

      isAnyNoteSelected.value = notes.any((note) => note.isSelected.value);
    }
  }

  void deleteSelectedNotes() {
    final List<int> selectedNoteIds = notes
        .where((note) => note.isSelected.value)
        .map((note) => note.id ?? 0)
        .toList();

    notes.removeWhere((note) => note.isSelected.value);

    selectedNoteIds.forEach((id) {
      NoteService.deleteNote(id);
    });

    selectedNotes.clear();
    isAnyNoteSelected.value = false;
  }

  void toggleFavoriteSelectedNotes() {
    final selectedNotes = notes.where((note) => note.isSelected.value).toList();
    final favoriteNotesCount = selectedNotes.where((note) => note.isFavourite.value).length;
    final nonFavoriteNotesCount = selectedNotes.length - favoriteNotesCount;

    if (favoriteNotesCount >= nonFavoriteNotesCount) {

      for (final note in selectedNotes) {
        note.isFavourite.value = false;
        NoteService.addOrUpdateNote(note);
      }
    } else {

      for (final note in selectedNotes) {
        note.isFavourite.value = true;
        NoteService.addOrUpdateNote(note);
      }
    }
  }

}
