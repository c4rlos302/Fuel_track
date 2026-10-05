import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/vehicles/models/vehicle.dart';
import '../../features/fuel/models/fuel_entry.dart';

class IsarDatabase {
  static Isar? _isar;

  static Future<Isar> get instance async {
    if (_isar != null) {
      return _isar!;
    }

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        VehicleSchema,
        FuelEntrySchema
      ],
      directory: dir.path,
    );

    return _isar!;
  }
}