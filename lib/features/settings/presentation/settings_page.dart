import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../vehicles/data/vehicle_repository.dart';
import '../../vehicles/models/vehicle.dart';

import '../../../core/providers/active_vehicle_provider.dart';
import '../../../core/utils/vehicle_icons.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final repository = VehicleRepository();

  List<Vehicle> vehicles = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadVehicles();
  }

  Future<void> loadVehicles() async {
    setState(() {
      loading = true;
    });

    final data = await repository.getVehicles();

    if (!mounted) return;

    setState(() {
      vehicles = data;

      loading = false;
    });
  }

  Future<void> deleteVehicle(Vehicle vehicle) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar vehículo"),

          content: Text("Se eliminarán también sus cargas de combustible."),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },

              child: const Text("Cancelar"),
            ),

            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },

              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    await repository.deleteVehicle(vehicle.id);

    if (ref.read(activeVehicleProvider) == vehicle.id) {
      await ref.read(activeVehicleProvider.notifier).clear();
    }

    loadVehicles();
  }

  @override
  Widget build(BuildContext context) {
    final activeId = ref.watch(activeVehicleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),

        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await context.push('/vehicles/add');

              if (result == true) {
                loadVehicles();
              }
            },
          ),
        ],
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),

              children: [
                const Text(
                  "Seleccionar vehículo activo",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                ...vehicles.map((vehicle) {
                  final selected = vehicle.id == activeId;

                  return Card(
                    child: ListTile(
                      leading: Icon(getVehicleIcon(vehicle.vehicleType)),

                      title: Text(vehicle.name),

                      subtitle: Text(
                        "${vehicle.brand} ${vehicle.model} ${vehicle.year}",
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (selected)
                            const Icon(Icons.check_circle, color: Colors.green),

                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              final result = await context.push(
                                '/vehicles/add',
                                extra: vehicle,
                              );

                              if (result == true) {
                                loadVehicles();
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteVehicle(vehicle);
                            },
                          ),
                        ],
                      ),

                      onTap: () async {
                        await ref
                            .read(activeVehicleProvider.notifier)
                            .setVehicle(vehicle.id);

                        if (!mounted) return;

                        setState(() {});
                      },
                    ),
                  );
                }),
              ],
            ),
    );
  }
}
