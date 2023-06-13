import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/Todo.dart';
import '../../logic/bloc/todo/todo_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// created the ScaffoldState key
  final scaffoldState = GlobalKey<ScaffoldState>();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: const Text('Todo Amplify'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scaffoldState.currentState?.showBottomSheet(
            (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter Todo Title',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<TodoBloc>(context).add(
                        TodoCreated(title: _controller.text),
                      );

                      _controller.text = '';

                      Navigator.pop(context);
                    },
                    child: const Text('Save Todo'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          // ! Loading
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // ! Success
          else if (state is TodoFetchSuccess) {
            return _successView(state);
          }
          // ! Error
          else if (state is TodoFailure) {
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

  ListView _successView(TodoFetchSuccess state) {
    List todos = state.todos;

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        Todo todo = todos[index];

        return Card(
          child: CheckboxListTile(
            value: todo.isComplete,
            title: Text(
              todo.title,
              style: TextStyle(
                color: Colors.grey,
                decoration: todo.isComplete
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: Colors.black,
              ),
            ),
            onChanged: (value) {
              BlocProvider.of<TodoBloc>(context).add(
                TodoUpdated(
                  todo: todo,
                  isComplete: value ?? false,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
