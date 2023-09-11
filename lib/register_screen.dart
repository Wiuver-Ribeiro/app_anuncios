import 'package:app_anuncios/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:app_anuncios/appbar.dart';

class RegisterScreen extends StatefulWidget {
  Todo? tarefa;

  RegisterScreen({this.tarefa});
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _subtitle = TextEditingController();
  final TextEditingController _price = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.tarefa != null) {
      _title.text = widget.tarefa!.title;
      _subtitle.text = widget.tarefa!.subtitle;
      _price.text = widget.tarefa!.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextFormField(
                      controller: _title,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextFormField(
                      controller: _subtitle,
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _price,
                      decoration: InputDecoration(
                        labelText: 'Preço',
                        prefix: Text("R\$"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    Todo newTask = Todo(_title.text,
                                        _subtitle.text, _price.text);
                                    Navigator.pop(context, newTask);
                                  }
                                },
                                child: Text('Adicionar'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                              ))),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Cancelar'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red)))),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
