import 'package:flutter/material.dart';

import '../models/vehicle_summary.dart';
import '../../features/home/presentation/widgets/stat_card.dart';

class StatisticsGrid extends StatelessWidget {
  final VehicleSummary summary;

  const StatisticsGrid({super.key, required this.summary});

  Color _getConsumptionColor(BuildContext context) {
    final consumption = summary.averageConsumption;

    if (consumption >= 20) {
      return Colors.green;
    }

    if (consumption >= 12) {
      return Colors.orange;
    }

    return Colors.red;
  }

  String _getConsumptionLabel() {
    final consumption = summary.averageConsumption;

    if (consumption >= 20) {
      return "Excelente";
    }

    if (consumption >= 12) {
      return "Normal";
    }

    return "Alto consumo";
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.15,

      children: [
        StatCard(
          icon: Icons.route,
          title: "Kilómetros",
          value: "${summary.totalKm.toStringAsFixed(0)} km",
        ),

        _ConsumptionCard(
          value: "${summary.averageConsumption.toStringAsFixed(1)} km/L",
          label: _getConsumptionLabel(),
          color: _getConsumptionColor(context),
        ),

        StatCard(
          icon: Icons.local_gas_station,
          title: "Litros",
          value: "${summary.totalLiters.toStringAsFixed(1)} L",
        ),

        StatCard(
          icon: Icons.attach_money,
          title: "Gasto total",
          value: "\$${summary.totalSpent.toStringAsFixed(2)}",
        ),

        StatCard(
          icon: Icons.toll,
          title: "Costo/km",
          value: "\$${summary.costPerKm.toStringAsFixed(2)}",
        ),

        StatCard(
          icon: Icons.trending_up,
          title: "Último consumo",
          value: "${summary.lastConsumption.toStringAsFixed(1)} km/L",
        ),

        StatCard(
          icon: Icons.repeat,
          title: "Cargas",
          value: "${summary.totalRefuels}",
        ),

        StatCard(
          icon: Icons.water_drop,
          title: "Prom. litros",
          value: "${summary.averageLiters.toStringAsFixed(1)} L",
        ),
      ],
    );
  }
}

class _ConsumptionCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _ConsumptionCard({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Icon(Icons.speed, size: 30, color: color),

            const Spacer(),

            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 8),

                Text(label, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
