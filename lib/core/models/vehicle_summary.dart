import '../../features/fuel/models/fuel_entry.dart';
import '../../features/vehicles/models/vehicle.dart';

class VehicleSummary {
  final Vehicle? vehicle;
  final FuelEntry? lastFuel;

  final double totalKm;
  final double averageConsumption;
  final double totalLiters;
  final double totalSpent;
  final double costPerKm;
  final double lastConsumption;
  final double averageSpent;
  final double averageLiters;
  final int totalRefuels;

  const VehicleSummary({
    required this.vehicle,
    required this.lastFuel,
    required this.totalKm,
    required this.averageConsumption,
    required this.totalLiters,
    required this.totalSpent,
    required this.costPerKm,
    required this.lastConsumption,
    required this.averageSpent,
    required this.averageLiters,
    required this.totalRefuels,
  });
}
