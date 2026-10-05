import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../models/consumption_point.dart';

class ConsumptionChart extends StatelessWidget {
  final List<ConsumptionPoint> points;

  const ConsumptionChart({super.key, required this.points});

  double get average {
    if (points.isEmpty) return 0;

    return points.map((e) => e.consumption).reduce((a, b) => a + b) /
        points.length;
  }

  double get best {
    if (points.isEmpty) return 0;

    return points.map((e) => e.consumption).reduce((a, b) => a > b ? a : b);
  }

  double get worst {
    if (points.isEmpty) return 0;

    return points.map((e) => e.consumption).reduce((a, b) => a < b ? a : b);
  }

  bool get improving {
    if (points.length < 2) return false;

    return points.last.consumption >= points.first.consumption;
  }

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return const SizedBox();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Consumo por carga",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Icon(
                  improving ? Icons.trending_up : Icons.trending_down,

                  color: improving ? Colors.green : Colors.red,
                ),

                const SizedBox(width: 8),

                Text(improving ? "Mejorando" : "Disminuyendo"),
              ],
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,

              children: [
                _infoChip("Prom. cargas", "${average.toStringAsFixed(1)} km/L"),

                _infoChip("Mejor", "${best.toStringAsFixed(1)} km/L"),

                _infoChip("Peor", "${worst.toStringAsFixed(1)} km/L"),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),

                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: average,
                        color: Theme.of(context).colorScheme.secondary,
                        strokeWidth: 3,
                        dashArray: [8, 4],
                        label: HorizontalLineLabel(
                          show: true,
                          alignment: Alignment.topRight,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          labelResolver: (line) =>
                              "Promedio ${average.toStringAsFixed(1)} km/L",
                        ),
                      ),
                    ],
                  ),

                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,

                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();

                          if (index < 0 || index >= points.length) {
                            return const SizedBox();
                          }

                          final date = points[index].date;

                          return Text(
                            "${date.day}/${date.month}",
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),

                  borderData: FlBorderData(show: false),

                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(points.length, (index) {
                        return FlSpot(
                          index.toDouble(),
                          points[index].consumption,
                        );
                      }),

                      isCurved: true,

                      color: colorScheme.primary,

                      barWidth: 3,

                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: colorScheme.primary,
                            strokeWidth: 2,
                            strokeColor: colorScheme.surface,
                          );
                        },
                      ),

                      belowBarData: BarAreaData(
                        show: true,
                        color: colorScheme.primary.withValues(alpha: 0.12),
                      ),
                    ),
                  ],

                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipPadding: const EdgeInsets.all(12),

                      getTooltipItems: (spots) {
                        return spots.map((spot) {
                          final point = points[spot.x.toInt()];

                          return LineTooltipItem(
                            "${point.date.day}/${point.date.month}/${point.date.year}\n"
                            "${point.consumption.toStringAsFixed(1)} km/L",
                            const TextStyle(fontWeight: FontWeight.bold),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(String title, String value) {
    return Chip(label: Text("$title: $value"));
  }
}
