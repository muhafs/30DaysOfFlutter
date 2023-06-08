import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dynamic List',
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  final List<Widget> _users = List.generate(
    20,
    (index) => Text('Muhamad $index'),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic List'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('List View'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Grid View'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _listContent(),
            _gridContent(),
          ],
        ),
      ),
    );
  }

  Widget _listContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _users.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: _users[index],
          ),
        );
      },
    );
  }

  Widget _gridContent() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _users.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Card(
          child: GridTile(
            child: Center(
              child: _users[index],
            ),
          ),
        );
      },
    );
  }
}
