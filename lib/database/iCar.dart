import 'package:app_anuncios/model/car.dart';

abstract class ICar {
  Future<Car?> save(Car car);
  Future<List<Car>> getAll();
  Future<Car?> getById(int id);
  Future<int?> edit(Car car);
  Future<int?> delete(Car car);
}
