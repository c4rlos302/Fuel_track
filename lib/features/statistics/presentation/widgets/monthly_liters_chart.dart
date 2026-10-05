import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/monthly_data.dart';

class MonthlyLitersChart extends StatelessWidget {
  final List<MonthlyData> data;

  const MonthlyLitersChart({super.key, required this.data});

  double get average {
    if (data.isEmpty) return 0;

    return data.map((e) => e.value).reduce((a, b) => a + b) / data.length;
  }

  double get highest {
    if (data.isEmpty) return 0;

    return data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
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
              "Litros por mes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _infoChip("Promedio", "${average.toStringAsFixed(1)} L"),

                _infoChip("Mayor", "${highest.toStringAsFixed(1)} L"),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 220,

              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(
                    show: true,
                    drawVerticalLine: false,
                  ),

                  borderData: FlBorderData(show: false),

                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,

                        getTitlesWidget: (value, meta) {
                          return Text(
                            "${value.toStringAsFixed(0)} L",
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,

                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();

                          if (index < 0 || index >= data.length) {
                            return const SizedBox();
                          }

                          const months = [
                            "Ene",
                            "Feb",
                            "Mar",
                            "Abr",
                            "May",
                            "Jun",
                            "Jul",
                            "Ago",
                            "Sep",
                            "Oct",
                            "Nov",
                            "Dic",
                          ];

                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              months[data[index].month.month - 1],
                              style: const TextStyle(fontSize: 11),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(data.length, (index) {
                        return FlSpot(index.toDouble(), data[index].value);
                      }),

                      isCurved: true,

                      barWidth: 3,

                      color: colorScheme.primary,

                      dotData: const FlDotData(show: true),

                      belowBarData: BarAreaData(
                        show: true,
                        color: colorScheme.primary.withValues(alpha: 0.12),
                      ),
                    ),
                  ],

                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipPadding: const EdgeInsets.all(12),

                      getTooltipColor: (spot) {
                        return colorScheme.primary;
                      },

                      getTooltipItems: (spots) {
                        return spots.map((spot) {
                          final index = spot.x.toInt();

                          if (index < 0 || index >= data.length) {
                            return null;
                          }

                          final month = data[index];

                          const months = [
                            "Enero",
                            "Febrero",
                            "Marzo",
                            "Abril",
                            "Mayo",
                            "Junio",
                            "Julio",
                            "Agosto",
                            "Septiembre",
                            "Octubre",
                            "Noviembre",
                            "Diciembre",
                          ];

                          return LineTooltipItem(
                            "${months[month.month.month - 1]} "
                            "${month.month.year}\n"
                            "${month.value.toStringAsFixed(1)} L",

                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),

                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: average,

                        color: colorScheme.secondary,

                        strokeWidth: 2,

                        dashArray: [8, 4],

                        label: HorizontalLineLabel(
                          show: true,

                          alignment: Alignment.topRight,

                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.secondary,
                          ),

                          labelResolver: (line) =>
                              "Promedio ${average.toStringAsFixed(1)} L",
                        ),
                      ),
                    ],
                  ),
                ),
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
