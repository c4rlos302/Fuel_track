import '../../fuel/data/fuel_repository.dart';
import '../../fuel/models/fuel_entry.dart';

import '../../statistics/services/fuel_statistics_service.dart';

import '../../vehicles/data/vehicle_repository.dart';

import '../../../core/models/vehicle_summary.dart';

class HomeRepository {
  final VehicleRepository vehicleRepository = VehicleRepository();

  final FuelRepository fuelRepository = FuelRepository();

  final FuelStatisticsService statisticsService = FuelStatisticsService();

  Future<VehicleSummary> getVehicleSummary(int vehicleId) async {
    final vehicle = await vehicleRepository.getVehicleById(vehicleId);

    final List<FuelEntry> entries = await fuelRepository
        .getFuelEntriesByVehicle(vehicleId);

    FuelEntry? lastFuel;

    if (entries.isNotEmpty) {
      lastFuel = entries.first;
    }

    return VehicleSummary(
      vehicle: vehicle,
      lastFuel: lastFuel,

      totalKm: statisticsService.calculateTotalKm(entries),
      averageConsumption: statisticsService.calculateAverageConsumption(
        entries,
      ),
      totalLiters: statisticsService.calculateTotalLiters(entries),
      totalSpent: statisticsService.calculateTotalSpent(entries),

      costPerKm: statisticsService.calculateCostPerKm(entries),
      lastConsumption: statisticsService.calculateLastConsumption(entries),
      averageSpent: statisticsService.calculateAverageSpent(entries),
      averageLiters: statisticsService.calculateAverageLiters(entries),
      totalRefuels: statisticsService.calculateTotalRefuels(entries),
    );
  }
}
