import 'package:isar_community/isar.dart';

part 'vehicle.g.dart';

@collection
class Vehicle {
  Id id = Isar.autoIncrement;

  late String name;

  late String brand;

  late String model;

  late int year;

  late String fuelType;
  
  late String vehicleType;

  late DateTime createdAt;
}