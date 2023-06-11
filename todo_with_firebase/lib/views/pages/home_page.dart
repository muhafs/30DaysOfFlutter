import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo.dart';
import '../../logic/bloc/todo/todo_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<TodoBloc>(context).add(TodoFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Firebase'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          // ! Loading
          if (state is TodoFetchInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // ! Success
          else if (state is TodoFetchSuccess) {
            List<Todo> todos = state.todos;

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                Todo todo = todos[index];

                return CheckboxListTile(
                  value: todo.isComplete,
                  title: Text(todo.title),
                  onChanged: (value) {},
                );
              },
            );
          }
          // ! Error
          else if (state is TodoFetchFailure) {
            return Center(
              child: Text(state.message.toString()),
            );
          }
          // ! Other
          else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
