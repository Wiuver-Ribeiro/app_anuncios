import 'dart:async';
import 'dart:io';

import 'package:app_anuncios/model/car.dart';
import 'package:flutter/material.dart';
import 'package:app_anuncios/appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class RegisterScreen extends StatefulWidget {
  Car? tarefa;

  RegisterScreen({this.tarefa});
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _subtitle = TextEditingController();
  final TextEditingController _price = TextEditingController();

  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.tarefa != null) {
      _title.text = widget.tarefa!.title;
      _subtitle.text = widget.tarefa!.subtitle;
      _price.text = widget.tarefa!.price;
      _image = widget.tarefa!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 75, 0, 0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            border: Border.all(width: 1, color: Colors.black),
                            shape: BoxShape.circle),
                        child: _image == null
                            ? const Icon(
                                Icons.add_a_photo,
                                size: 30,
                              )
                            : ClipOval(
                                child: Image.file(_image!),
                              )),
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? pickedFile =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        setState(() {
                          _image = File(pickedFile.path);
                        });
                      }
                    },
                  ),
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
                                  File? savedImage;
                                  if (_formKey.currentState!.validate()) {
                                    Car newTask = Car(
                                      _title.text,
                                      _subtitle.text,
                                      _price.text,
                                      image: savedImage,
                                    );
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
