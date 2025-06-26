import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotesPage extends StatefulWidget {
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Map<String, String>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesString = prefs.getString('notes') ?? '[]';
    setState(() {
      _notes = List<Map<String, String>>.from(json.decode(notesString));
    });
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notes', json.encode(_notes));
  }

  void _addNoteDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Tambah Catatan"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Judul"),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: "Isi"),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text("Simpan"),
            onPressed: () {
              final title = titleController.text.trim();
              final content = contentController.text.trim();
              if (title.isNotEmpty && content.isNotEmpty) {
                setState(() {
                  _notes.add({'title': title, 'content': content});
                });
                _saveNotes();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
    _saveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catatan Pribadi"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: "Tambah Catatan",
            onPressed: _addNoteDialog,
          )
        ],
      ),
      body: _notes.isEmpty
          ? Center(child: Text("Belum ada catatan."))
          : ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, i) => Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(_notes[i]['title'] ?? ""),
            subtitle: Text(_notes[i]['content'] ?? ""),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteNote(i),
            ),
          ),
        ),
      ),
    );
  }
}
