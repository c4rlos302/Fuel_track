import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../vehicles/models/vehicle.dart';
import '../../../../core/utils/vehicle_icons.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle? vehicle;

  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    if (vehicle == null) {
      return Card(
        elevation: 2,

        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [
              Icon(
                Icons.directions_car_outlined,
                size: 70,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 16),

              Text(
                "Sin vehículo registrado",

                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                "Agrega un vehículo para comenzar a registrar combustible.",

                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              FilledButton.icon(
                onPressed: () {
                  context.push('/vehicles/add');
                },

                icon: const Icon(Icons.add),

                label: const Text("Agregar vehículo"),
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

        child: Row(
          children: [
            Container(
              width: 70,

              height: 70,

              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,

                borderRadius: BorderRadius.circular(20),
              ),

              child: Icon(
                getVehicleIcon(vehicle?.vehicleType),

                size: 38,

                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    vehicle!.name,

                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "${vehicle!.brand} ${vehicle!.model}",

                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,

                    children: [
                      Chip(
                        avatar: const Icon(Icons.calendar_today, size: 16),

                        label: Text("${vehicle!.year}"),
                      ),

                      Chip(
                        avatar: const Icon(Icons.local_gas_station, size: 16),

                        label: Text(vehicle!.fuelType),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
