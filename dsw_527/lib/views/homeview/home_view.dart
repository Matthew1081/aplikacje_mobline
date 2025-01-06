import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../databse/database_helper.dart';
import '../login/login_view.dart';

class HomeView extends StatefulWidget {
  final int userId;

  const HomeView({super.key, required this.userId});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    print('Logged in as userId: ${widget.userId}');
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _dbHelper.getNotes(widget.userId);
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _addOrEditNote({Map<String, dynamic>? note}) async {
    final TextEditingController _titleController = TextEditingController(
      text: note?['title'] ?? '',
    );
    final TextEditingController _noteController = TextEditingController(
      text: note?['content'] ?? '',
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Enter title (optional)',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _noteController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Enter your note here',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final title = _titleController.text.trim();
              final content = _noteController.text.trim();
              if (content.isNotEmpty) {
                final now = DateTime.now();
                final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

                if (note == null) {
                  // Dodanie nowej notatki
                  await _dbHelper.addNote(
                    userId: widget.userId,
                    title: title.isEmpty ? null : title,
                    content: content,
                    date: formattedDate,
                  );
                } else {
                  // Aktualizacja istniejącej notatki
                  await _dbHelper.updateNote(
                    noteId: note['id'],
                    title: title.isEmpty ? null : title,
                    content: content,
                    date: formattedDate, // Aktualizacja daty
                  );
                }

                Navigator.pop(context);
                _loadNotes();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }






  Future<void> _deleteNote(int noteId) async {
    await _dbHelper.deleteNote(noteId);
    _loadNotes();
  }

  Future<void> _signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _notes.isEmpty
                ? const Center(
              child: Text(
                'No notes available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                :ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(note['title'] ?? 'Untitled Note'),
                    subtitle: Text('Last updated: ${note['date']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _addOrEditNote(note: note),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteNote(note['id']),
                        ),
                      ],
                    ),
                  ),

                );
              },
            )



          ),
          Text(
            'Logged in as userId: ${widget.userId}',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _addOrEditNote(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'Add Note',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
