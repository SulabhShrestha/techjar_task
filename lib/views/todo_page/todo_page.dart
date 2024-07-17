import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techjar_task/models/todo_model.dart';
import 'package:techjar_task/providers/todos_provider.dart';
import 'package:techjar_task/views/todo_page/widgets/todo_item.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider).todos;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's tasks"),
        backgroundColor: Colors.blue.shade300,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodo(context, ref);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoItem(
                todoModel: todos[index],
              );
            },
          ),
        ),
      ]),
    );
  }

  void addTodo(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("New task"),
          content: TextField(
            controller: textEditingController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Task Name',
              hintText: 'eg. Buy milk',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.watch(todosProvider).addTodo(
                      TodoModel(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        todo: textEditingController.text,
                        completed: false,
                      ),
                    );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
