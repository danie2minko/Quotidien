import 'package:flutter/material.dart';
import 'package:quotidien/components/mydrawer.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:quotidien/components/task_tile.dart';
import 'package:quotidien/models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> _tasks;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Accueil')),
    Center(child: Text('Historique')),
    Center(child: Text('Profil')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [Text('ACCEUIL'), SizedBox(width: 180), Icon(Icons.person)],
        ),
      ),
      drawer: Mydrawer(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(249, 139, 66, 1.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          Navigator.pushNamed(context, '/addtask');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(249, 139, 66, 1.0),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),

      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];

          return TaskTile(
            task: task,
            onTap: () {
              print('Tâche cliquée : ${task.name}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Détails pour : ${task.name}')),
              );
            },
            onStatusChanged: (isCompleted) {
              setState(() {
                task.isCompleted = isCompleted ?? false;
              });
            },
          );
        },
      ),
    );
  }
}
