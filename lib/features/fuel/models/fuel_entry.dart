import 'package:isar_community/isar.dart';

part 'fuel_entry.g.dart';

@collection
class FuelEntry {
  Id id = Isar.autoIncrement;

  late int vehicleId;

  late DateTime date;

  late int currentKm;

  late double liters;

  late double pricePerLiter;

  late double total;

  late String fuelType;

  double? consumption;

  bool fullTank = false;

  String? station;

  String? notes;
}
