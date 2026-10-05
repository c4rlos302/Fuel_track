import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/monthly_data.dart';

class MonthlySpentChart extends StatelessWidget {
  final List<MonthlyData> data;

  const MonthlySpentChart({super.key, required this.data});

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
              "Gasto mensual",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _infoChip("Promedio", "\$${average.toStringAsFixed(2)}"),

                _infoChip("Mayor", "\$${highest.toStringAsFixed(2)}"),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 220,

              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: true, drawVerticalLine: false),

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
                        reservedSize: 48,

                        getTitlesWidget: (value, meta) {
                          if (value == 0) {
                            return const Text("\$0");
                          }

                          if (value >= 1000) {
                            return Text(
                              "\$${(value / 1000).toStringAsFixed(1)}k",
                              style: const TextStyle(fontSize: 10),
                            );
                          }

                          return Text(
                            "\$${value.toStringAsFixed(0)}",
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

                          final month = data[index].month;

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
                              months[month.month - 1],
                              style: const TextStyle(fontSize: 11),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  barGroups: List.generate(data.length, (index) {
                    return BarChartGroupData(
                      x: index,

                      barRods: [
                        BarChartRodData(
                          toY: data[index].value,
                          width: 20,

                          color: colorScheme.primary,

                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(6),
                          ),
                        ),
                      ],
                    );
                  }),

                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) {
                        return colorScheme.primary;
                      },

                      tooltipPadding: const EdgeInsets.all(12),

                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final month = data[groupIndex].month;

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

                        return BarTooltipItem(
                          "${months[month.month - 1]} ${month.year}\n"
                          "\$${rod.toY.toStringAsFixed(2)}",

                          const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
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
