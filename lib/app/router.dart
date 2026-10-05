import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../features/fuel/models/fuel_entry.dart';
import '../features/vehicles/models/vehicle.dart';

import '../features/home/presentation/home_page.dart';
import '../features/vehicles/presentation/add_vehicle_page.dart';
import '../features/vehicles/presentation/vehicles_page.dart';
import '../features/fuel/presentation/fuel_history_page.dart';
import '../features/fuel/presentation/add_fuel_page.dart';
import '../features/statistics/presentation/statistics_page.dart';
import '../features/settings/presentation/settings_page.dart';
import '../features/scan/presentation/scan_test_page.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

final appRouter = GoRouter(
  initialLocation: '/',

  observers: [routeObserver],

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/vehicles/add',
      builder: (context, state) {
        final vehicle = state.extra as Vehicle?;

        return AddVehiclePage(vehicle: vehicle);
      },
    ),

    GoRoute(
      path: '/vehicles',
      builder: (context, state) {
        return const VehiclesPage();
      },
    ),

    GoRoute(
      path: '/fuel-history',
      builder: (context, state) {
        return const FuelHistoryPage();
      },
    ),

    GoRoute(
      path: '/add-fuel',
      builder: (context, state) {
        final fuel = state.extra as FuelEntry?;

        return AddFuelPage(fuelToEdit: fuel);
      },
    ),

    GoRoute(
      path: '/statistics',
      builder: (context, state) {
        return const StatisticsPage();
      },
    ),

    GoRoute(
      path: '/settings',
      builder: (context, state) {
        return const SettingsPage();
      },
    ),
    GoRoute(
      path: '/scan-test',
      builder: (context, state) => const ScanTestPage(),
    ),
  ],
);
