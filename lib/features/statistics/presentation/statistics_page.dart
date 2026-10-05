import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/statistics_repository.dart';
import '../services/fuel_statistics_service.dart';
import '../../../core/providers/active_vehicle_provider.dart';

import '../../fuel/models/fuel_entry.dart';
import '../../../core/models/vehicle_summary.dart';
import '../../vehicles/data/vehicle_repository.dart';

import 'widgets/consumption_chart.dart';
import 'widgets/monthly_spent_chart.dart';
import 'widgets/monthly_liters_chart.dart';
import '../../../core/widgets/statistics_grid.dart';

import '../models/consumption_point.dart';
import '../models/monthly_data.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  final vehicleRepository = VehicleRepository();
  final repository = StatisticsRepository();
  final service = FuelStatisticsService();

  List<FuelEntry> entries = [];
  List<ConsumptionPoint> consumptionHistory = [];
  List<MonthlyData> monthlySpent = [];
  List<MonthlyData> monthlyLiters = [];

  VehicleSummary? summary;

  String selectedPeriod = "Todo";

  bool loading = true;

  @override
  void initState() {
    super.initState();

    ref.listenManual(activeVehicleProvider, (_, _) {
      loadData();
    });

    loadData();
  }

  Future<void> loadData() async {
    final vehicleId = ref.read(activeVehicleProvider);

    if (vehicleId == null) {
      if (!mounted) return;

      setState(() {
        entries = [];
        loading = false;
      });

      return;
    }

    final data = await repository.getFuelEntriesByVehicle(vehicleId);
    final filteredData = filterEntries(data);

    final km = service.calculateTotalKm(filteredData);
    final consumption = service.calculateAverageConsumption(filteredData);
    final spent = service.calculateTotalSpent(filteredData);
    final liters = service.calculateTotalLiters(filteredData);
    final cost = service.calculateCostPerKm(filteredData);
    final newSummary = VehicleSummary(
      vehicle: summary?.vehicle,
      lastFuel: filteredData.isNotEmpty ? filteredData.first : null,
      totalKm: km,
      averageConsumption: consumption,
      totalLiters: liters,
      totalSpent: spent,
      costPerKm: cost,
      lastConsumption: service.calculateLastConsumption(filteredData),
      averageSpent: service.calculateAverageSpent(filteredData),
      averageLiters: service.calculateAverageLiters(filteredData),
      totalRefuels: service.calculateTotalRefuels(filteredData)
    );
    final history = service.calculateConsumptionHistory(filteredData);
    final monthly = service.calculateMonthlySpent(filteredData);
    final litersMonthly = service.calculateMonthlyConsumption(
      filteredData,
    );

    if (!mounted) return;

    setState(() {
      summary = newSummary;

      entries = filteredData;

      consumptionHistory = history;
      monthlySpent = monthly;
      monthlyLiters = litersMonthly;

      loading = false;
    });
  }

  List<FuelEntry> filterEntries(List<FuelEntry> data) {
    final now = DateTime.now();

    switch (selectedPeriod) {
      case "Último mes":
        return data.where((e) {
          return e.date.isAfter(now.subtract(const Duration(days: 30)));
        }).toList();

      case "Últimos 3 meses":
        return data.where((e) {
          return e.date.isAfter(now.subtract(const Duration(days: 90)));
        }).toList();

      case "Último año":
        return data.where((e) {
          return e.date.isAfter(now.subtract(const Duration(days: 365)));
        }).toList();

      default:
        return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (summary == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Estadísticas")),
        body: const Center(child: Text("No hay datos para mostrar.")),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Estadísticas")),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadData,

              child: ListView(
                padding: const EdgeInsets.all(16),

                children: [
                  DropdownButtonFormField<String>(
                    initialValue: selectedPeriod,

                    decoration: const InputDecoration(
                      labelText: "Periodo",
                      border: OutlineInputBorder(),
                    ),

                    items: const [
                      DropdownMenuItem(value: "Todo", child: Text("Todo")),

                      DropdownMenuItem(
                        value: "Último mes",
                        child: Text("Último mes"),
                      ),

                      DropdownMenuItem(
                        value: "Últimos 3 meses",
                        child: Text("Últimos 3 meses"),
                      ),

                      DropdownMenuItem(
                        value: "Último año",
                        child: Text("Último año"),
                      ),
                    ],

                    onChanged: (value) {
                      setState(() {
                        selectedPeriod = value!;
                        loading = true;
                      });

                      loadData();
                    },
                  ),
                  const SizedBox(height: 16),
                  StatisticsGrid(summary: summary!),
                  ConsumptionChart(points: consumptionHistory),
                  const SizedBox(height: 16),
                  MonthlySpentChart(data: monthlySpent),
                  const SizedBox(height: 16),
                  MonthlyLitersChart(data: monthlyLiters),
                  const SizedBox(height: 50),
                ],
              ),
            ),
    );
  }
}