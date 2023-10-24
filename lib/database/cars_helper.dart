import 'package:app_anuncios/database/database_helper.dart';
import 'package:app_anuncios/database/iCar.dart';
import 'package:app_anuncios/model/car.dart';
import 'package:sqflite/sqflite.dart';

class CarHelper implements ICar {
  static final String tableName = "cars";
  static final String idColumn = "id";
  static final String nameColumn = "marca";
  static final String descriptColumn = "modelo";
  static final String valueColumn = "preco";
  static final String imageColumn = "imagem";

  static get createScript {
    return "CREATE TABLE $tableName($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "$nameColumn TEXT NOT NULL, $descriptColumn TEXT NOT NULL, $valueColumn FLOAT NOT NULL, $imageColumn STRING NULL);";
  }

  @override
  Future<Car?> save(Car car) async {
    Database? db = await DataBaseHelper().db;
    if (db != null) {
      car.id = await db.insert(tableName, car.toMap());
      return car;
    }
    return null;
  }

  @override
  Future<int?> delete(Car car) async {
    Database? db = await DataBaseHelper().db;
    if (db != null) {
      return await db.delete(tableName, where: "id=?", whereArgs: [car.id]);
    }
  }

  @override
  Future<int?> edit(Car car) async {
    Database? db = await DataBaseHelper().db;
    if (db != null) {
      return await db
          .update(tableName, car.toMap(), where: "id=?", whereArgs: [car.id]);
    }
  }

  @override
  Future<List<Car>> getAll() async {
    Database? db = await DataBaseHelper().db;
    List<Car> cars = List.empty(growable: true);
    if (db != null) {
      List<Map> returnedCars = await db.query(tableName, columns: [
        idColumn,
        nameColumn,
        descriptColumn,
        valueColumn,
        imageColumn
      ]);

      for (Map mCar in returnedCars) {
        cars.add(Car.fromMap(mCar));
      }
    }
    return cars;
  }

  @override
  Future<Car?> getById(int id) async {
    Database? db = await DataBaseHelper().db;
    if (db != null) {
      List<Map> returnedCar = await db.query(tableName,
          columns: [
            idColumn,
            nameColumn,
            descriptColumn,
            valueColumn,
            imageColumn
          ],
          where: "id=?",
          whereArgs: [id]);

      return Car.fromMap(returnedCar.first);
    }

    return null;
  }
}
