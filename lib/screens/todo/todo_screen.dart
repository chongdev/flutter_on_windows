import 'package:flutter/material.dart';
import 'package:flutter_on_windows/db/todo_database.dart';
import 'package:flutter_on_windows/models/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late List<Todo> todos = [];
  bool isLoading = false;

  late String title = '';

  @override
  void initState() {
    super.initState();

    refreshTodos();
  }

  Future refreshTodos() async {
    setState(() => isLoading = true);

    todos = await TodoDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  void addTodo() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final todo = Todo(
        title: title,
        createdTime: DateTime.now(),
      );

      await TodoDatabase.instance.create(todo);
      refreshTodos();
    }
  }

  Future updateTodo(Todo todo) async {
    await TodoDatabase.instance.update(todo);
    refreshTodos();
  }

  Future deleteTodo(Todo todo) async {
    int? id = todo.id;
    if( id != null ){
      await TodoDatabase.instance.delete(id);
      refreshTodos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white38,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        maxLines: 1,
                        initialValue: title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'เพิ่มงาน',
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                        validator: (title) => title != null && title.isEmpty
                            ? 'The title cannot be empty'
                            : null,
                        onChanged: (value) => title = value,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () => addTodo(),
                  child: const Text('บันทึก'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : todos.isEmpty
                      ? const Text(
                          'No Todo',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )
                      : _buildTodos(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTodos() => ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          late Todo todo = todos[index];

          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: ListTile(
              leading: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              title: Text(
                todo.title,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      // todo.title = "asdd";

                      updateTodo(todo);
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () => deleteTodo(todos[index]),
                    icon: const Icon(Icons.delete, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
