import 'dart:convert';
import 'dart:io';
import 'package:app_anuncios/model/car.dart';

import 'package:path_provider/path_provider.dart';

class FilePersistence {
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    String localPath = directory.path;
    File localFile = File('$localPath/taskFile.json');
    if (localFile.existsSync()) {
      return localFile;
    } else {
      return localFile.create(recursive: true);
    }
  }

  Future saveData(List<Car> cars) async {
    final localFile = await _getLocalFile();
    List carList = [];
    cars.forEach((car) {
      carList.add(car.toMap());
    });
    String data = json.encode(carList);
    return localFile.writeAsString(data);
  }

  Future<List<Car>?> getData() async {
    try {
      final localFile = await _getLocalFile();
      List carList = [];
      List<Car> cars = [];

      String content = await localFile.readAsString();
      carList = json.decode(content);

      carList.forEach((tarefa) {
        cars.add(Car.fromMap(tarefa));
      });

      return cars;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
