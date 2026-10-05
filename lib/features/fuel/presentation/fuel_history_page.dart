import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/fuel_repository.dart';
import '../models/fuel_entry.dart';
import '../../../core/providers/active_vehicle_provider.dart';

import '../../vehicles/data/vehicle_repository.dart';
import '../../vehicles/models/vehicle.dart';

class FuelHistoryPage extends ConsumerStatefulWidget {
  const FuelHistoryPage({super.key});

  @override
  ConsumerState<FuelHistoryPage> createState() => _FuelHistoryPageState();
}

class _FuelHistoryPageState extends ConsumerState<FuelHistoryPage> {
  final FuelRepository repository = FuelRepository();
  final VehicleRepository vehicleRepository = VehicleRepository();

  List<FuelEntry> entries = [];
  List<Vehicle> vehicles = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    ref.listenManual(activeVehicleProvider, (_, _) {
      loadEntries();
    });
    loadEntries();
  }

  Future<void> loadEntries() async {
    final activeVehicle = ref.read(activeVehicleProvider);

    if (activeVehicle == null) {
      setState(() {
        entries = [];

        loading = false;
      });

      return;
    }

    final fuelData = await repository.getFuelEntriesByVehicle(activeVehicle);

    final vehicleData = await vehicleRepository.getVehicles();

    if (!mounted) return;

    setState(() {
      entries = fuelData;
      vehicles = vehicleData;
      loading = false;
    });
  }

  Vehicle? getVehicle(int id) {
    try {
      return vehicles.firstWhere((vehicle) => vehicle.id == id);
    } catch (_) {
      return null;
    }
  }

  int? getKmDifference(int index) {
    final current = entries[index];

    if (!current.fullTank) {
      return null;
    }

    for (int i = index + 1; i < entries.length; i++) {
      final previous = entries[i];

      if (previous.fullTank) {
        final difference = current.currentKm - previous.currentKm;

        if (difference > 0) {
          return difference;
        }

        return null;
      }
    }

    return null;
  }

  Future<void> deleteFuel(FuelEntry fuel) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar carga"),
          content: const Text("¿Seguro que deseas eliminar este registro?"),
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

    await repository.deleteFuelEntry(fuel.id);

    await repository.recalculateConsumptionsAfterDelete(fuel.vehicleId);

    if (!mounted) return;

    await loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historial de combustible")),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : entries.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_gas_station, size: 70),

                  SizedBox(height: 16),

                  Text(
                    "No hay cargas registradas",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: loadEntries,

              child: ListView.builder(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 50,
                ),

                itemCount: entries.length,

                itemBuilder: (context, index) {
                  final fuel = entries[index];
                  final kmDifference = getKmDifference(index);
                  double? consumption = fuel.consumption;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),

                    child: Padding(
                      padding: const EdgeInsets.all(16),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                DateFormat("dd/MM/yyyy").format(fuel.date),

                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "\$${fuel.total.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Divider(),

                          _buildInfoRow(
                            Icons.speed,
                            "Kilometraje",
                            "${fuel.currentKm} km",
                          ),

                          if (kmDifference != null) ...[
                            const SizedBox(height: 8),

                            _buildInfoRow(
                              Icons.route,
                              "Recorrido",
                              "${kmDifference.toString()} km",
                            ),
                          ],

                          const SizedBox(height: 8),

                          _buildInfoRow(
                            Icons.local_gas_station,
                            "Litros",
                            "${fuel.liters.toStringAsFixed(2)} L",
                          ),
                          if (fuel.fullTank) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.local_gas_station,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  "Tanque lleno",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],

                          const SizedBox(height: 8),

                          _buildInfoRow(
                            Icons.speed,
                            "Consumo",
                            consumption == null
                                ? "Sin calcular"
                                : "${consumption.toStringAsFixed(1)} km/L",
                            valueColor: consumption == null
                                ? null
                                : _consumptionColor(consumption),
                          ),

                          if (consumption != null) ...[
                            const SizedBox(height: 6),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Chip(
                                avatar: Icon(
                                  Icons.speed,
                                  size: 18,
                                  color: _consumptionColor(consumption),
                                ),
                                label: Text(_consumptionLabel(consumption)),
                                backgroundColor: _consumptionColor(
                                  consumption,
                                ).withValues(alpha: 0.15),
                              ),
                            ),
                          ],

                          const SizedBox(height: 8),

                          _buildInfoRow(
                            Icons.attach_money,
                            "Precio/L",
                            "\$${fuel.pricePerLiter.toStringAsFixed(2)}",
                          ),

                          if (fuel.station != null) ...[
                            const SizedBox(height: 8),

                            _buildInfoRow(
                              Icons.store,
                              "Gasolinera",
                              fuel.station!,
                            ),
                          ],

                          if (fuel.notes != null) ...[
                            const SizedBox(height: 8),

                            _buildInfoRow(Icons.note_alt, "Notas", fuel.notes!),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  final result = await context.push(
                                    '/add-fuel',
                                    extra: fuel,
                                  );

                                  if (result == true) {
                                    loadEntries();
                                  }
                                },
                              ),

                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteFuel(fuel);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String title,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18),

          const SizedBox(width: 8),

          SizedBox(
            width: 95,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          Expanded(
            child: Text(value, style: TextStyle(color: valueColor)),
          ),
        ],
      ),
    );
  }

  Color _consumptionColor(double consumption) {
    if (consumption >= 18) {
      return Colors.green;
    }

    if (consumption >= 12) {
      return Colors.orange;
    }

    return Colors.red;
  }

  String _consumptionLabel(double consumption) {
    if (consumption >= 18) {
      return "Excelente";
    }

    if (consumption >= 12) {
      return "Normal";
    }

    return "Alto consumo";
  }
}
