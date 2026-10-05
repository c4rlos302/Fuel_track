import 'package:isar_community/isar.dart';

import '../../../core/database/isar_database.dart';

import '../../fuel/models/fuel_entry.dart';

class StatisticsRepository {
  Future<List<FuelEntry>> getAllFuelEntries() async {
    final isar = await IsarDatabase.instance;

    return isar.fuelEntrys.where().sortByDateDesc().findAll();
  }

  Future<List<FuelEntry>> getFuelEntriesByVehicle(int vehicleId) async {
    final isar = await IsarDatabase.instance;

    return isar.fuelEntrys
        .filter()
        .vehicleIdEqualTo(vehicleId)
        .sortByDateDesc()
        .findAll();
  }

  Future<List<FuelEntry>> getFuelEntriesFromDate(DateTime startDate) async {
    final isar = await IsarDatabase.instance;

    return isar.fuelEntrys
        .filter()
        .dateGreaterThan(startDate)
        .sortByDateDesc()
        .findAll();
  }
}
