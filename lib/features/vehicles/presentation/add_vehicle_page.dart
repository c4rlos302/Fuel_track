import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/active_vehicle_provider.dart';
import '../data/vehicle_repository.dart';
import '../models/vehicle.dart';

class AddVehiclePage extends ConsumerStatefulWidget {
  final Vehicle? vehicle;

  const AddVehiclePage({super.key, this.vehicle});

  @override
  ConsumerState<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends ConsumerState<AddVehiclePage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();

  String fuelType = 'Gasolina';
  String vehicleType = "Auto";

  final repository = VehicleRepository();

  Future<void> saveVehicle() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final vehicle = widget.vehicle ?? Vehicle();

    vehicle
      ..name = nameController.text
      ..brand = brandController.text
      ..model = modelController.text
      ..year = int.parse(yearController.text)
      ..fuelType = fuelType
      ..vehicleType = vehicleType;

    Vehicle savedVehicle;

    if (widget.vehicle == null) {
      // Crear nuevo
      vehicle.createdAt = DateTime.now();

      savedVehicle = await repository.createVehicle(vehicle);
    } else {
      // Actualizar existente
      await repository.updateVehicle(vehicle);

      savedVehicle = vehicle;
    }

    await ref.read(activeVehicleProvider.notifier).setVehicle(savedVehicle.id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.vehicle == null ? 'Vehículo guardado' : 'Vehículo actualizado',
        ),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  void initState() {
    super.initState();

    loadVehicle();
  }

  void loadVehicle() {
    if (widget.vehicle == null) return;

    nameController.text = widget.vehicle!.name;

    brandController.text = widget.vehicle!.brand;

    modelController.text = widget.vehicle!.model;

    yearController.text = widget.vehicle!.year.toString();

    fuelType = widget.vehicle!.fuelType;

    vehicleType = widget.vehicle!.vehicleType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.vehicle == null ? 'Agregar vehículo' : 'Editar vehículo',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingresa un nombre' : null,
              ),

              TextFormField(
                controller: brandController,
                decoration: const InputDecoration(labelText: 'Marca'),
              ),

              TextFormField(
                controller: modelController,
                decoration: const InputDecoration(labelText: 'Modelo'),
              ),

              TextFormField(
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Año'),
              ),

              DropdownButtonFormField<String>(
                initialValue: vehicleType,

                decoration: const InputDecoration(
                  labelText: "Tipo de vehículo",
                ),

                items: const [
                  DropdownMenuItem(value: "Auto", child: Text("🚗 Auto")),

                  DropdownMenuItem(value: "Moto", child: Text("🏍️ Moto")),

                  DropdownMenuItem(
                    value: "Camioneta",
                    child: Text("🚙 Camioneta"),
                  ),

                  DropdownMenuItem(value: "Camion", child: Text("🚚 Camión")),
                ],

                onChanged: (value) {
                  setState(() {
                    vehicleType = value!;
                  });
                },
              ),

              DropdownButtonFormField<String>(
                initialValue: fuelType,

                items: const [
                  DropdownMenuItem(value: 'Gasolina', child: Text('Gasolina')),
                  DropdownMenuItem(value: 'Diesel', child: Text('Diesel')),
                  DropdownMenuItem(
                    value: 'Electrico',
                    child: Text('Eléctrico'),
                  ),
                ],

                onChanged: (value) {
                  setState(() {
                    fuelType = value!;
                  });
                },

                decoration: const InputDecoration(labelText: 'Combustible'),
              ),

              const SizedBox(height: 24),

              FilledButton(
                onPressed: saveVehicle,

                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
