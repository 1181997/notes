import 'package:get/get.dart';
import '../base_model/note_class.dart';
import '../service_model/service_model.dart';

class NoteController extends GetxController {
  var notes = RxList<Note>();
  var isLoading = true.obs;
  RxBool isListView = true.obs;

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
}
