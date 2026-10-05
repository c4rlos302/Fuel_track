import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/active_vehicle_provider.dart';

import '../data/fuel_repository.dart';
import '../models/fuel_entry.dart';
import '../../../core/database/isar_database.dart';

import '../../vehicles/models/vehicle.dart';
import '../../vehicles/data/vehicle_repository.dart';

enum FuelFormStep { info, costs, additional }

class AddFuelPage extends ConsumerStatefulWidget {
  final FuelEntry? fuelToEdit;

  const AddFuelPage({super.key, this.fuelToEdit});
  @override
  ConsumerState<AddFuelPage> createState() => _AddFuelPageState();
}

class _AddFuelPageState extends ConsumerState<AddFuelPage> {
  final _formKey = GlobalKey<FormState>();

  final kmController = TextEditingController();
  final litersController = TextEditingController();
  final priceController = TextEditingController();
  final totalController = TextEditingController();
  final stationController = TextEditingController();
  final notesController = TextEditingController();

  final kmFocus = FocusNode();
  final litersFocus = FocusNode();
  final totalFocus = FocusNode();
  final priceFocus = FocusNode();
  final stationFocus = FocusNode();
  final notesFocus = FocusNode();

  DateTime selectedDate = DateTime.now();
  String? dateError;

  double total = 0;

  Vehicle? selectedVehicle;
  String? selectedFuelType;

  bool saving = false;
  bool fullTank = false;
  bool loading = true;

  FuelFormStep currentStep = FuelFormStep.info;

  void calculateFromLiters() {
    final liters = double.tryParse(litersController.text) ?? 0;

    final price = double.tryParse(priceController.text) ?? 0;

    if (liters > 0 && price > 0) {
      final result = liters * price;

      setState(() {
        total = result;
        totalController.text = result.toStringAsFixed(2);
      });
    }
  }

  void calculateFromTotal() {
    final totalValue = double.tryParse(totalController.text) ?? 0;

    final price = double.tryParse(priceController.text) ?? 0;

    if (totalValue > 0 && price > 0) {
      final result = totalValue / price;

      setState(() {
        total = totalValue;
        litersController.text = result.toStringAsFixed(2);
      });
    }
  }

  Future<void> selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateError = null;
      });
    }
  }

  Future<void> loadVehicles() async {
    final activeVehicleId = ref.read(activeVehicleProvider);

    if (activeVehicleId == null) {
      return;
    }

    final vehicle = await VehicleRepository().getVehicleById(activeVehicleId);

    if (!mounted) return;

    setState(() {
      selectedVehicle = vehicle;
    });
  }

  Future<void> saveData() async {
    if (saving) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedVehicle == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Selecciona un vehículo")));
      return;
    }

    double? consumption;
    final currentKm = int.parse(kmController.text);

    if (fullTank) {
      final lastFullTank = await FuelRepository().getPreviousFullTank(
        vehicleId: selectedVehicle!.id,
        currentKm: currentKm,
        excludeId: widget.fuelToEdit?.id,
      );

      if (lastFullTank != null) {
        final km = currentKm - lastFullTank.currentKm;

        if (km > 0) {
          consumption = km / double.parse(litersController.text);
        }
      }
    }

    final lastFuel = await FuelRepository().getLastFuelEntryByVehicle(
      selectedVehicle!.id,
    );

    if (lastFuel != null &&
        currentKm < lastFuel.currentKm &&
        widget.fuelToEdit == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "El kilometraje debe ser mayor a ${lastFuel.currentKm} km",
          ),
        ),
      );

      return;
    }

    if (litersController.text.isEmpty && totalController.text.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingresa litros o total pagado")),
      );

      return;
    }

    setState(() {
      saving = true;
    });

    final fuel = FuelEntry()
      ..vehicleId = selectedVehicle!.id
      ..date = selectedDate
      ..currentKm = int.parse(kmController.text)
      ..liters = double.parse(litersController.text)
      ..pricePerLiter = double.parse(priceController.text)
      ..total = double.parse(totalController.text)
      ..consumption = consumption
      ..fullTank = fullTank
      ..fuelType = selectedVehicle!.fuelType
      ..station = stationController.text.trim().isEmpty
          ? null
          : stationController.text.trim()
      ..notes = notesController.text.trim().isEmpty
          ? null
          : notesController.text.trim();

    try {
      if (widget.fuelToEdit == null) {
        await FuelRepository().addFuelEntry(fuel);
      } else {
        fuel.id = widget.fuelToEdit!.id;

        await FuelRepository().updateFuelEntry(fuel);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Carga guardada correctamente")),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error al guardar: $e")));
    } finally {
      if (mounted) {
        setState(() {
          saving = false;
        });
      }
    }
  }

  Future<void> updateFuelEntry(FuelEntry entry) async {
    final isar = await IsarDatabase.instance;

    await isar.writeTxn(() async {
      await isar.fuelEntrys.put(entry);
    });
  }

  void loadFuelData() {
    final fuel = widget.fuelToEdit;
    if (fuel == null) return;

    selectedDate = fuel.date;
    kmController.text = fuel.currentKm.toString();
    litersController.text = fuel.liters.toString();
    totalController.text = fuel.total.toStringAsFixed(2);
    priceController.text = fuel.pricePerLiter.toString();
    stationController.text = fuel.station ?? "";
    notesController.text = fuel.notes ?? "";
    total = fuel.total;
    fullTank = fuel.fullTank;
  }

  void selectAll(TextEditingController controller) {
    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller.text.length,
    );
  }

  void nextStep() {
    switch (currentStep) {
      case FuelFormStep.info:
        setState(() {
          currentStep = FuelFormStep.costs;
        });

        Future.delayed(const Duration(milliseconds: 300), () {
          if (!mounted) return;

          FocusScope.of(context).requestFocus(priceFocus);
        });

        break;

      case FuelFormStep.costs:
        setState(() {
          currentStep = FuelFormStep.additional;
        });

        Future.delayed(const Duration(milliseconds: 300), () {
          if (!mounted) return;

          FocusScope.of(context).requestFocus(stationFocus);
        });

        break;

      case FuelFormStep.additional:
        break;
    }
  }

  void previousStep() {
    setState(() {
      switch (currentStep) {
        case FuelFormStep.info:
          break;
        case FuelFormStep.costs:
          currentStep = FuelFormStep.info;
          break;
        case FuelFormStep.additional:
          currentStep = FuelFormStep.costs;
          break;
      }
    });
  }

  Future<bool> validateKilometers() async {
    final currentKm = int.tryParse(kmController.text);

    if (currentKm == null || currentKm <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingresa un kilometraje válido")),
      );

      return false;
    }

    if (selectedVehicle == null) {
      return false;
    }

    final lastFuel = await FuelRepository().getLastFuelEntryByVehicle(
      selectedVehicle!.id,
    );

    if (lastFuel != null &&
        widget.fuelToEdit == null &&
        currentKm < lastFuel.currentKm) {
      if (!mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "El kilometraje debe ser mayor o igual a ${lastFuel.currentKm} km",
          ),
        ),
      );

      return false;
    }

    return true;
  }

  Future<bool> validateInfoStep() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    return await validateKilometers();
  }

  bool validateCostStep() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    final liters = double.tryParse(litersController.text);
    final totalValue = double.tryParse(totalController.text);
    final price = double.tryParse(priceController.text);

    // Validar precio
    if (price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingresa un precio por litro válido")),
      );

      return false;
    }

    final hasLiters = liters != null && liters > 0;
    final hasTotal = totalValue != null && totalValue > 0;

    // Ninguno de los dos
    if (!hasLiters && !hasTotal) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingresa los litros o el total pagado")),
      );

      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();

    loadVehicles();

    if (widget.fuelToEdit != null) {
      loadFuelData();
    }
  }

  @override
  void dispose() {
    kmController.dispose();
    litersController.dispose();
    priceController.dispose();
    totalController.dispose();
    stationController.dispose();
    notesController.dispose();
    kmFocus.dispose();
    priceFocus.dispose();
    litersFocus.dispose();
    totalFocus.dispose();
    stationFocus.dispose();
    notesFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.fuelToEdit == null
              ? "Registrar combustible"
              : "Editar combustible",
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildVehicleCard(),

              const SizedBox(height: 20),

              _buildStepIndicator(),

              const SizedBox(height: 24),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(sizeFactor: animation, child: child),
                  );
                },
                child: _buildCurrentStep(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleCard() {
    if (selectedVehicle == null) {
      return const SizedBox();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.directions_car, size: 34),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedVehicle!.name,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text("${selectedVehicle!.brand} ${selectedVehicle!.model}"),

                  Text(
                    "${selectedVehicle!.year} • ${selectedVehicle!.fuelType}",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case FuelFormStep.info:
        return KeyedSubtree(
          key: const ValueKey("info"),
          child: _buildInfoStep(),
        );

      case FuelFormStep.costs:
        return KeyedSubtree(
          key: const ValueKey("costs"),
          child: _buildCostStep(),
        );

      case FuelFormStep.additional:
        return KeyedSubtree(
          key: const ValueKey("additional"),
          child: _buildAdditionalStep(),
        );
    }
  }

  Widget _buildInfoStep() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 3),

        FormField<DateTime>(
          validator: (_) {
            if (selectedDate.isAfter(DateTime.now())) {
              return "La fecha no puede ser futura";
            }

            return null;
          },

          builder: (field) {
            return InkWell(
              onTap: () async {
                await selectDate();

                field.didChange(selectedDate);
              },

              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: "Fecha",

                  border: const OutlineInputBorder(),

                  prefixIcon: const Icon(Icons.calendar_month),

                  errorText: field.errorText,
                ),

                child: Text(DateFormat("dd/MM/yyyy").format(selectedDate)),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: kmController,
          focusNode: kmFocus,

          onTap: () => selectAll(kmController),

          textInputAction: TextInputAction.done,

          keyboardType: TextInputType.number,

          decoration: const InputDecoration(
            labelText: "Kilometraje actual",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.speed),
          ),

          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Ingresa el kilometraje";
            }

            final km = int.tryParse(value);

            if (km == null || km <= 0) {
              return "Ingresa un kilometraje válido";
            }

            return null;
          },
        ),

        const SizedBox(height: 30),

        Align(
          alignment: Alignment.centerRight,
          child: FilledButton.icon(
            onPressed: () async {
              if (await validateInfoStep()) {
                nextStep();
              }
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Siguiente"),
          ),
        ),
      ],
    );
  }

  Widget _buildCostStep() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 3),

        TextFormField(
          controller: priceController,
          focusNode: priceFocus,

          onTap: () => selectAll(priceController),

          textInputAction: TextInputAction.next,

          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(litersFocus);
          },

          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => calculateFromLiters(),
          decoration: const InputDecoration(
            labelText: "Precio por litro",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.attach_money),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Ingresa el precio";
            }

            final price = double.tryParse(value);

            if (price == null || price <= 0) {
              return "Ingresa un precio válido";
            }

            return null;
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: litersController,
          focusNode: litersFocus,

          onTap: () {
            selectAll(litersController);
          },

          textInputAction: TextInputAction.next,

          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(totalFocus);
          },

          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => calculateFromLiters(),
          decoration: const InputDecoration(
            labelText: "Litros",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.local_gas_station),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Ingresa los litros";
            }

            final liters = double.tryParse(value);

            if (liters == null || liters <= 0) {
              return "Ingresa litros válidos";
            }

            return null;
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: totalController,
          focusNode: totalFocus,

          onTap: () {
            selectAll(totalController);
          },

          textInputAction: TextInputAction.done,

          keyboardType: const TextInputType.numberWithOptions(decimal: true),

          onChanged: (_) => calculateFromTotal(),

          decoration: const InputDecoration(
            labelText: "Total pagado",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.attach_money),
          ),

          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Ingresa el total";
            }

            final total = double.tryParse(value);

            if (total == null || total <= 0) {
              return "Ingresa un total válido";
            }

            return null;
          },
        ),

        const SizedBox(height: 16),

        CheckboxListTile(
          value: fullTank,

          onChanged: (value) {
            setState(() {
              fullTank = value ?? false;
            });
          },

          title: const Text("Tanque lleno"),
          secondary: const Icon(Icons.local_gas_station),
        ),

        const SizedBox(height: 20),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text("Total", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  "\$${total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 30),

        Row(
          children: [
            OutlinedButton.icon(
              onPressed: previousStep,
              icon: const Icon(Icons.arrow_back),
              label: const Text("Anterior"),
            ),

            const Spacer(),

            TextButton(
              onPressed: () {
                if (validateCostStep()) {
                  setState(() {
                    currentStep = FuelFormStep.additional;
                  });
                }
              },
              child: const Text("Agregar información adicional"),
            ),
          ],
        ),
        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: saving
                ? null
                : () {
                    if (validateCostStep()) {
                      saveData();
                    }
                  },
            icon: const Icon(Icons.save),
            label: const Text("Guardar"),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalStep() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 3),

        TextFormField(
          controller: stationController,
          focusNode: stationFocus,

          onTap: () {
            selectAll(stationController);
          },

          textInputAction: TextInputAction.next,

          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(notesFocus);
          },

          decoration: const InputDecoration(
            labelText: "Gasolinera (Opcional)",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.store),
          ),
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: notesController,
          focusNode: notesFocus,

          onTap: () {
            selectAll(notesController);
          },

          maxLines: 3,
          decoration: const InputDecoration(
            labelText: "Notas",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.note_alt),
          ),
        ),

        const SizedBox(height: 30),

        Row(
          children: [
            OutlinedButton.icon(
              onPressed: previousStep,
              icon: const Icon(Icons.arrow_back),
              label: const Text("Anterior"),
            ),

            const Spacer(),

            FilledButton.icon(
              onPressed: saving ? null : saveData,
              icon: saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
              label: Text(saving ? "Guardando..." : "Guardar"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    final currentIndex = switch (currentStep) {
      FuelFormStep.info => 0,
      FuelFormStep.costs => 1,
      FuelFormStep.additional => 2,
    };

    return Column(
      children: [
        Row(
          children: [
            _buildStepCircle(active: currentIndex >= 0, label: "Información"),

            Expanded(
              child: Divider(
                thickness: 2,
                color: currentIndex >= 1
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade300,
              ),
            ),

            _buildStepCircle(active: currentIndex >= 1, label: "Costos"),

            Expanded(
              child: Divider(
                thickness: 2,
                color: currentIndex >= 2
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade300,
              ),
            ),

            _buildStepCircle(active: currentIndex >= 2, label: "Adicional"),
          ],
        ),
      ],
    );
  }

  Widget _buildStepCircle({required bool active, required String label}) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),

          width: 32,
          height: 32,

          decoration: BoxDecoration(
            shape: BoxShape.circle,

            color: active
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
          ),

          child: Center(
            child: Icon(
              Icons.check,
              size: 18,
              color: active ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          label,
          style: TextStyle(
            fontSize: 12,

            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
