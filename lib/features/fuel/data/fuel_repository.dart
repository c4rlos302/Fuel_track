import 'package:isar_community/isar.dart';

import '../../../core/database/isar_database.dart';
import '../models/fuel_entry.dart';

class FuelRepository {
  Future<void> addFuelEntry(FuelEntry entry) async {
    final isar = await IsarDatabase.instance;

    await isar.writeTxn(() async {
      await isar.fuelEntrys.put(entry);
    });
  }

  Future<List<FuelEntry>> getFuelEntries() async {
    final isar = await IsarDatabase.instance;

    return isar.fuelEntrys.where().sortByCurrentKmDesc().findAll();
  }

  Future<List<FuelEntry>> getFuelEntriesByVehicle(int vehicleId) async {
    final isar = await IsarDatabase.instance;

    return isar.fuelEntrys
        .filter()
        .vehicleIdEqualTo(vehicleId)
        .sortByCurrentKmDesc()
        .findAll();
  }

  Future<FuelEntry?> getLastFuelEntryByVehicle(int vehicleId) async {
    final isar = await IsarDatabase.instance;

    return isar.fuelEntrys
        .filter()
        .vehicleIdEqualTo(vehicleId)
        .sortByCurrentKmDesc()
        .findFirst();
  }

  Future<FuelEntry?> getLastFullTankByVehicle(int vehicleId) async {
    final isar = await IsarDatabase.instance;

    return isar.fuelEntrys
        .filter()
        .vehicleIdEqualTo(vehicleId)
        .fullTankEqualTo(true)
        .sortByCurrentKmDesc()
        .findFirst();
  }

  Future<FuelEntry?> getPreviousFullTank({
    required int vehicleId,
    required int currentKm,
    int? excludeId,
  }) async {
    final isar = await IsarDatabase.instance;

    final entries = await isar.fuelEntrys
        .filter()
        .vehicleIdEqualTo(vehicleId)
        .fullTankEqualTo(true)
        .currentKmLessThan(currentKm)
        .sortByCurrentKmDesc()
        .findAll();

    for (final entry in entries) {
      if (entry.id != excludeId) {
        return entry;
      }
    }

    return null;
  }

  Future<void> recalculateConsumptionsAfterDelete(int vehicleId) async {
    final isar = await IsarDatabase.instance;

    final entries = await isar.fuelEntrys
        .filter()
        .vehicleIdEqualTo(vehicleId)
        .sortByCurrentKm()
        .findAll();

    FuelEntry? previousFullTank;

    await isar.writeTxn(() async {
      for (final entry in entries) {
        if (!entry.fullTank) {
          continue;
        }

        if (previousFullTank == null) {
          entry.consumption = null;
        } else {
          final km = entry.currentKm - previousFullTank!.currentKm;

          if (km > 0 && entry.liters > 0) {
            entry.consumption = km / entry.liters;
          } else {
            entry.consumption = null;
          }
        }

        await isar.fuelEntrys.put(entry);

        previousFullTank = entry;
      }
    });
  }

  Future<void> deleteFuelEntry(Id id) async {
    final isar = await IsarDatabase.instance;

    await isar.writeTxn(() async {
      await isar.fuelEntrys.delete(id);
    });
  }

  Future<void> updateFuelEntry(FuelEntry entry) async {
    final isar = await IsarDatabase.instance;

    await isar.writeTxn(() async {
      await isar.fuelEntrys.put(entry);
    });
  }
}
