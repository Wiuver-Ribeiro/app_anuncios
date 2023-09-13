import 'package:app_anuncios/appbar.dart';
import 'package:app_anuncios/model/todo.dart';
import 'package:app_anuncios/register_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> _lista = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: _lista.length,
          itemBuilder: (context, index) {
            Todo item = _lista[index];

            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.green,
                child: const Align(
                  alignment: Alignment(-0.9, 0.0),
                  child: Icon(Icons.edit, color: Colors.white),
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                child: const Align(
                  alignment: Alignment(0.9, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  setState(() {
                    _lista.removeAt(index);
                  });
                }
              },
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  Todo? editedTask = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen(tarefa: item)));
                  if (editedTask != null) {
                    setState(() {
                      _lista.removeAt(index);
                      _lista.insert(index, editedTask);
                    });
                  }
                  return false;
                } else {
                  return true;
                }
              },
              child: ListTile(
                title: Text(_lista[index].title),
                subtitle: Text(_lista[index].subtitle),
                trailing: Text(_lista[index].price),
                onTap: () {},
                onLongPress: () async {
                  Todo editedTask = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen(tarefa: item)));
                  if (editedTask != null) {
                    setState(() {
                      _lista.removeAt(index);
                      _lista.insert(index, editedTask);
                    });
                  }
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            Todo todo = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
            setState(() {
              _lista.add(todo);
            });
          } catch (error) {
            print("Error: ${error.toString()}");
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFF3483FA),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), label: 'Home'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.link_rounded), label: 'Compartilhar'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined), label: 'Minhas compras'),
      ]),
    );
  }
}
