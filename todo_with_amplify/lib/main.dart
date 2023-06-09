import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'logic/bloc/todo_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc()..add(TodoFetched()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoFetchInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoFetchSuccess) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> todos =
                state.todos;

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                String todoID = todos[index].id;
                Map<String, dynamic> todo = todos[index].data();

                return CheckboxListTile(
                  key: ValueKey(todoID),
                  value: todo['isComplete'],
                  title: Text(todo['title']),
                  onChanged: (value) {},
                );
              },
            );
          } else if (state is TodoFetchFailure) {
            return const Center(
              child: Text('error'),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
