import 'dart:io';

import 'package:app_anuncios/database/cars_helper.dart';

class Car {
  int? id;
  late String title;
  late String subtitle;
  late String price;
  bool done = false;
  File? image;

  Car(this.title, this.subtitle, this.price, this.image, {this.id});

  Car.fromMap(Map map) {
    // id = map[CarHelper.idColumn];
    // title = map[CarHelper.nameColumn];
    // subtitle = map[CarHelper.descriptColumn];
    // price = map[CarHelper.valueColumn];
    // image = map[CarHelper.imageColumn] != null
    //     ? File(map[CarHelper.imageColumn])
    //     : null;

    id = map[CarHelper.idColumn];
    title = map[CarHelper.nameColumn];
    subtitle = map[CarHelper.descriptColumn];
    price = map[CarHelper.valueColumn];
    image = map[CarHelper.imageColumn] != null
        ? File(map[CarHelper.imageColumn])
        : null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      CarHelper.idColumn: id,
      CarHelper.nameColumn: title,
      CarHelper.descriptColumn: subtitle,
      CarHelper.valueColumn: price,
      CarHelper.imageColumn: image != null ? image!.path : null
    };
    return map;
  }
}
