import '../../fuel/models/fuel_entry.dart';
import '../models/consumption_point.dart';
import '../models/monthly_data.dart';

class FuelStatisticsService {
  double calculateAverageConsumption(List<FuelEntry> entries) {
    final fullTanks = [...entries]
      ..removeWhere((entry) => !entry.fullTank)
      ..sort((a, b) => a.currentKm.compareTo(b.currentKm));

    if (fullTanks.length < 2) {
      return 0;
    }

    double totalKm = 0;
    double totalLiters = 0;

    for (int i = 1; i < fullTanks.length; i++) {
      final previous = fullTanks[i - 1];
      final current = fullTanks[i];

      final km = current.currentKm - previous.currentKm;

      if (km > 0 && current.liters > 0) {
        totalKm += km;
        totalLiters += current.liters;
      }
    }

    if (totalLiters == 0) {
      return 0;
    }

    return totalKm / totalLiters;
  }

  double calculateTotalSpent(List<FuelEntry> entries) {
    return entries.fold(0, (sum, item) => sum + item.total);
  }

  double calculateTotalLiters(List<FuelEntry> entries) {
    return entries.fold(0, (sum, item) => sum + item.liters);
  }

  double calculateCostPerKm(List<FuelEntry> entries) {
    if (entries.length < 2) {
      return 0;
    }

    final sorted = [...entries]
      ..sort((a, b) => a.currentKm.compareTo(b.currentKm));

    final km = sorted.last.currentKm - sorted.first.currentKm;

    if (km <= 0) {
      return 0;
    }

    return calculateTotalSpent(sorted) / km;
  }

  double calculateTotalKm(List<FuelEntry> entries) {
    if (entries.length < 2) {
      return 0;
    }

    final sorted = [...entries]
      ..sort((a, b) => a.currentKm.compareTo(b.currentKm));

    return (sorted.last.currentKm - sorted.first.currentKm).toDouble();
  }

  int calculateTotalRefuels(List<FuelEntry> entries) {
    return entries.length;
  }

  double calculateLastConsumption(List<FuelEntry> entries) {
    final fullTanks = [...entries]
      ..removeWhere((entry) => !entry.fullTank)
      ..sort((a, b) => a.currentKm.compareTo(b.currentKm));

    if (fullTanks.length < 2) {
      return 0;
    }

    final last = fullTanks.last;
    final previous = fullTanks[fullTanks.length - 2];

    final km = last.currentKm - previous.currentKm;

    if (km <= 0 || last.liters <= 0) {
      return 0;
    }

    return km / last.liters;
  }

  double calculateAverageSpent(List<FuelEntry> entries) {
    if (entries.isEmpty) {
      return 0;
    }

    return calculateTotalSpent(entries) / entries.length;
  }

  double calculateAverageLiters(List<FuelEntry> entries) {
    if (entries.isEmpty) {
      return 0;
    }

    return calculateTotalLiters(entries) / entries.length;
  }

  List<ConsumptionPoint> calculateConsumptionHistory(List<FuelEntry> entries) {
    final fullTanks = [...entries]
      ..removeWhere((entry) => !entry.fullTank)
      ..sort((a, b) => a.currentKm.compareTo(b.currentKm));

    if (fullTanks.length < 2) {
      return [];
    }

    final List<ConsumptionPoint> result = [];

    for (int i = 1; i < fullTanks.length; i++) {
      final previous = fullTanks[i - 1];
      final current = fullTanks[i];

      final km = current.currentKm - previous.currentKm;

      if (km <= 0 || current.liters <= 0) {
        continue;
      }

      result.add(
        ConsumptionPoint(date: current.date, consumption: km / current.liters),
      );
    }

    return result;
  }

  List<MonthlyData> calculateMonthlySpent(List<FuelEntry> entries) {
    final Map<String, double> grouped = {};

    for (final entry in entries) {
      final key = "${entry.date.year}-${entry.date.month}";

      grouped[key] = (grouped[key] ?? 0) + entry.total;
    }

    return grouped.entries.map((item) {
      final parts = item.key.split('-');

      return MonthlyData(
        month: DateTime(int.parse(parts[0]), int.parse(parts[1])),

        value: item.value,
      );
    }).toList()..sort((a, b) => a.month.compareTo(b.month));
  }

  List<MonthlyData> calculateMonthlyConsumption(List<FuelEntry> entries) {
    final Map<String, double> grouped = {};

    for (final entry in entries) {
      final key = "${entry.date.year}-${entry.date.month}";

      grouped[key] = (grouped[key] ?? 0) + entry.liters;
    }

    return grouped.entries.map((item) {
      final parts = item.key.split('-');

      return MonthlyData(
        month: DateTime(int.parse(parts[0]), int.parse(parts[1])),

        value: item.value,
      );
    }).toList()..sort((a, b) => a.month.compareTo(b.month));
  }
}
