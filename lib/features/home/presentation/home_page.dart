import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.dart';

import '../data/home_repository.dart';
import '../../../core/models/vehicle_summary.dart';
import '../../../core/providers/active_vehicle_provider.dart';

import '../../../core/widgets/statistics_grid.dart';
import 'widgets/last_fuel_card.dart';
import 'widgets/quick_actions.dart';
import 'widgets/animated_card.dart';
import 'widgets/vehicle_selector.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with RouteAware {
  final HomeRepository repository = HomeRepository();

  VehicleSummary? summary;

  bool loading = true;

  Future<void> loadData() async {
    final vehicleId = ref.read(activeVehicleProvider);

    if (vehicleId == null) {
      setState(() {
        summary = null;

        loading = false;
      });

      return;
    }

    final result = await repository.getVehicleSummary(vehicleId);

    if (!mounted) return;

    setState(() {
      summary = result;

      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    ref.listenManual(activeVehicleProvider, (_, _) {
      loadData();
    });
    loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);

    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    super.dispose();
  }

  @override
  void didPopNext() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (summary == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("FuelTrack"),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                context.push('/settings');
              },
            ),
          ],
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.directions_car_outlined, size: 80),

              const SizedBox(height: 16),

              const Text(
                "No hay vehículo seleccionado",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              FilledButton.icon(
                onPressed: () {
                  context.push('/settings');
                },

                icon: const Icon(Icons.settings),

                label: const Text("Seleccionar vehículo"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("FuelTrack"),

        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push('/scan-test');
            },
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: loadData,

        child: ListView(
          padding: const EdgeInsets.all(16),

          children: [
            AnimatedCard(delay: 100, child: const VehicleSelector()),

            const SizedBox(height: 10),

            _sectionTitle("Acciones rápidas", icon: Icons.bolt),

            AnimatedCard(delay: 200, child: const QuickActions()),

            _sectionTitle("Última carga", icon: Icons.local_gas_station),

            AnimatedCard(
              delay: 300,
              child: LastFuelCard(fuel: summary?.lastFuel),
            ),

            const SizedBox(height: 20),

            _sectionTitle("Estadísticas", icon: Icons.analytics_outlined),

            if (summary != null)
              AnimatedCard(
                delay: 400,
                child: StatisticsGrid(summary: summary!),
              ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 8, bottom: 10),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
