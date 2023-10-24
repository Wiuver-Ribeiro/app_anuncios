import 'dart:ffi';
import 'package:app_anuncios/appbar.dart';
import 'package:app_anuncios/model/car.dart';
import 'package:app_anuncios/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void enviarEmail() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'wiuver.ribeiro@gmail.com',
    query:
        'subject=Dados&body=Aqui está os detalhes do carro conforme solicitado! ',
  );
  String url = params.toString();
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    debugPrint('Could not launch $url');
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<Car> _lista = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: _lista.length,
          itemBuilder: (context, index) {
            Car item = _lista[index];

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
                  Car? editedTask = await Navigator.push(
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
                leading: item.image != null
                    ? CircleAvatar(
                        child: ClipOval(child: Image.file(item.image!)),
                      )
                    : const SizedBox(),
                title: Text(_lista[index].title),
                subtitle:
                    Text(_lista[index].subtitle + " " + _lista[index].price),
                trailing: FloatingActionButton(
                  heroTag: _lista[index],
                  onPressed: enviarEmail,
                  child: Icon(Icons.share),
                ),
                onTap: () {},
                onLongPress: () async {
                  Car editedTask = await Navigator.push(
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
            Car todo = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
            setState(() {
              _lista.add(todo);
              final snackBar = SnackBar(
                content: Text("Carro anunciado com sucesso!"),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
