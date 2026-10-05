import 'package:isar_community/isar.dart';

import '../../../core/database/isar_database.dart';
import '../models/vehicle.dart';
import '../../fuel/models/fuel_entry.dart';

class VehicleRepository {
  Future<List<Vehicle>> getVehicles() async {
    final isar = await IsarDatabase.instance;

    return isar.vehicles.where().findAll();
  }

  Future<Vehicle?> getVehicleById(int id) async {
    final isar = await IsarDatabase.instance;

    return await isar.vehicles.get(id);
  }

  Future<Vehicle> createVehicle(Vehicle vehicle) async {
    final isar = await IsarDatabase.instance;

    await isar.writeTxn(() async {
      await isar.vehicles.put(vehicle);
    });

    return vehicle;
  }

  Future<void> updateVehicle(Vehicle vehicle) async {
    final isar = await IsarDatabase.instance;

    await isar.writeTxn(() async {
      await isar.vehicles.put(vehicle);
    });
  }

  Future<void> deleteVehicle(int vehicleId) async {
    final isar = await IsarDatabase.instance;

    await isar.writeTxn(() async {
      await isar.fuelEntrys.filter().vehicleIdEqualTo(vehicleId).deleteAll();

      await isar.vehicles.delete(vehicleId);
    });
  }
}
