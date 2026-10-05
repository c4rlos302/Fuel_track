import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../fuel/models/fuel_entry.dart';

class LastFuelCard extends StatelessWidget {
  final FuelEntry? fuel;

  const LastFuelCard({super.key, required this.fuel});

  @override
  Widget build(BuildContext context) {
    if (fuel == null) {
      return Card(
        elevation: 2,

        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [
              Icon(
                Icons.local_gas_station_outlined,

                size: 60,

                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 16),

              Text(
                "Sin cargas registradas",

                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                "Registra tu primera carga para ver el historial.",

                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 3,

      clipBehavior: Clip.antiAlias,

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  "Última carga",

                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),

                Icon(
                  Icons.receipt_long,

                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,

                borderRadius: BorderRadius.circular(16),
              ),

              child: Row(
                children: [
                  const Icon(Icons.calendar_month),

                  const SizedBox(width: 12),

                  Text(
                    DateFormat("dd/MM/yyyy").format(fuel!.date),

                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            _FuelInfoRow(
              icon: Icons.speed,
              title: "Kilometraje",
              value: "${fuel!.currentKm} km",
            ),

            _FuelInfoRow(
              icon: Icons.local_gas_station,
              title: "Litros",
              value: "${fuel!.liters.toStringAsFixed(2)} L",
            ),

            _FuelInfoRow(
              icon: Icons.attach_money,
              title: "Precio/L",
              value: "\$${fuel!.pricePerLiter.toStringAsFixed(2)}",
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.payments,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "Total",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),

                  Text(
                    "\$${fuel!.total.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),

            if (fuel!.fullTank) ...[
              const SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.check_circle, size: 18, color: Colors.green),

                  const SizedBox(width: 6),

                  const Text(
                    "Tanque lleno",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],

            if (fuel!.station != null && fuel!.station!.isNotEmpty)
              _FuelInfoRow(
                icon: Icons.store,

                title: "Gasolinera",

                value: fuel!.station!,
              ),

            _FuelInfoRow(
              icon: Icons.local_fire_department,

              title: "Combustible",

              value: fuel!.fuelType,
            ),
          ],
        ),
      ),
    );
  }
}

class _FuelInfoRow extends StatelessWidget {
  final IconData icon;

  final String title;

  final String value;

  final bool bold;

  const _FuelInfoRow({
    required this.icon,

    required this.title,

    required this.value,

    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      child: Row(
        children: [
          Icon(icon, size: 22, color: Theme.of(context).colorScheme.primary),

          const SizedBox(width: 12),

          Expanded(child: Text(title)),

          Text(
            value,

            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
