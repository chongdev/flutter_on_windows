import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_on_windows/db/note_database_sqflite_ffi.dart';
import 'package:flutter_on_windows/db/note_database_sqflite.dart';
import 'package:flutter_on_windows/models/note.dart';
import 'package:flutter_on_windows/screens/note/edit_note_page.dart';
import 'package:intl/intl.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({Key? key, required this.noteId}) : super(key: key);

  final int noteId;

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);


    //
    if( Platform.isWindows ){
      note = await NoteDatabaseSQFLiteFfi.instance.readNote(widget.noteId);
    }
    else{
      note = await NoteDatabaseSQFLite.instance.readNote(widget.noteId);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [editButton(), deleteButton()],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat.yMMMd().format(note.createdTime),
                    style: const TextStyle(color: Colors.white38),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    note.description,
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                  )
                ],
              ),
            ),
    );
  }

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {


          await NoteDatabaseSQFLiteFfi.instance.delete(widget.noteId);
          // if( Platform.isWindows ){
          //
          // }
          // else{
          //   await NotesDatabase.instance.delete(widget.noteId);
          // }

          Navigator.of(context).pop();
        },
      );
}
