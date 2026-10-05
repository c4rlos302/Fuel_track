import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String activeVehicleKey = "active_vehicle_id";

  static Future<void> setActiveVehicle(int id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(activeVehicleKey, id);
  }

  static Future<int?> getActiveVehicle() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(activeVehicleKey);
  }

  static Future<void> clearActiveVehicle() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(activeVehicleKey);
  }
}
