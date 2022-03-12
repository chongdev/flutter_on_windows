import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_on_windows/db/note_database_sqflite.dart';
import 'package:flutter_on_windows/db/note_database_sqflite_ffi.dart';
import 'package:flutter_on_windows/models/note.dart';
import 'package:flutter_on_windows/screens/note/edit_note_page.dart';
import 'package:flutter_on_windows/screens/note/note_detail_page.dart';
import 'package:flutter_on_windows/widgets/note_card_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    if (Platform.isWindows) {
      NoteDatabaseSQFLiteFfi.instance.close();
    } else {
      NoteDatabaseSQFLite.instance.close();
    }

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    if (Platform.isWindows) {
      notes = await NoteDatabaseSQFLiteFfi.instance.readAllNotes();
    } else {
      notes = await NoteDatabaseSQFLite.instance.readAllNotes();
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    String title = Platform.isWindows ? 'Notes on windows' : 'Notes on android';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        actions: const [Icon(Icons.search), SizedBox(width: 12)],
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : notes.isEmpty
                ? const Text(
                    'No Notes',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                : buildNotes(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddEditNotePage()),
          );
          refreshNotes();
        },
      ),
    );
  }

  Widget buildNotes() => MasonryGridView.count(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
