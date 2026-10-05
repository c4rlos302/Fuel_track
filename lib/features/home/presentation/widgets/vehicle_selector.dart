import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/active_vehicle_provider.dart';
import '../../../../core/utils/vehicle_icons.dart';

import '../../../vehicles/data/vehicle_repository.dart';
import '../../../vehicles/models/vehicle.dart';

class VehicleSelector extends ConsumerStatefulWidget {
  const VehicleSelector({super.key});

  @override
  ConsumerState<VehicleSelector> createState() => _VehicleSelectorState();
}

class _VehicleSelectorState extends ConsumerState<VehicleSelector> {
  final repository = VehicleRepository();

  List<Vehicle> vehicles = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadVehicles();
  }

  Future<void> loadVehicles() async {
    final data = await repository.getVehicles();

    if (!mounted) return;

    setState(() {
      vehicles = data;
      loading = false;
    });
  }

  Future<void> showVehicleSelector() async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,

      builder: (context) {
        final activeId = ref.read(activeVehicleProvider);

        return SafeArea(
          child: ListView(
            shrinkWrap: true,

            children: [
              const ListTile(
                title: Text(
                  "Seleccionar vehículo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),

              ...vehicles.map((vehicle) {
                final selected = vehicle.id == activeId;

                return Card(
                  color: selected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          child: Icon(getVehicleIcon(vehicle.vehicleType)),
                        ),
                      ],
                    ),

                    title: Text(vehicle.name),

                    subtitle: Text(
                      "${vehicle.brand} ${vehicle.model} • ${vehicle.year}\n${vehicle.fuelType}",
                    ),

                    isThreeLine: true,

                    onTap: () async {
                      Navigator.pop(context);

                      await ref
                          .read(activeVehicleProvider.notifier)
                          .setVehicle(vehicle.id);
                    },
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (selected)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),

                            PopupMenuButton<String>(
                              onSelected: (value) async {
                                switch (value) {
                                  case 'edit':
                                    Navigator.pop(context);

                                    final result = await context.push(
                                      '/vehicles/add',
                                      extra: vehicle,
                                    );

                                    if (!mounted) return;

                                    if (result == true) {
                                      loadVehicles();
                                    }

                                    break;

                                  case 'delete':
                                    Navigator.pop(context);

                                    await deleteVehicle(vehicle);

                                    break;
                                }
                              },

                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Editar'),
                                ),

                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Eliminar'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.add_circle),

                title: const Text("Agregar vehículo"),

                onTap: () async {
                  Navigator.pop(context);

                  final result = await context.push('/vehicles/add');

                  if (result == true) {
                    loadVehicles();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> deleteVehicle(Vehicle vehicle) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar vehículo"),
          content: Text(
            "¿Seguro que deseas eliminar '${vehicle.name}'?\n\n"
            "También se eliminarán todas sus cargas de combustible.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    final activeId = ref.read(activeVehicleProvider);

    await repository.deleteVehicle(vehicle.id);

    if (activeId == vehicle.id) {
      final remaining = await repository.getVehicles();

      if (remaining.isEmpty) {
        await ref.read(activeVehicleProvider.notifier).clear();
      } else {
        await ref
            .read(activeVehicleProvider.notifier)
            .setVehicle(remaining.first.id);
      }
    }

    await loadVehicles();
  }

  @override
  Widget build(BuildContext context) {
    final activeId = ref.watch(activeVehicleProvider);

    Vehicle? vehicle;

    try {
      vehicle = vehicles.firstWhere((v) => v.id == activeId);
    } catch (_) {}

    if (loading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (vehicle == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text("No hay vehículo seleccionado"),
        ),
      );
    }

    return Card(
      child: InkWell(
        onTap: showVehicleSelector,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  getVehicleIcon(vehicle.vehicleType),
                  size: 30,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vehículo activo",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      vehicle.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      "${vehicle.brand} ${vehicle.model} • ${vehicle.year}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
