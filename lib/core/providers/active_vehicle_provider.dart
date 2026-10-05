import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/preferences.dart';

final activeVehicleProvider = NotifierProvider<ActiveVehicleNotifier, int?>(
  ActiveVehicleNotifier.new,
);

class ActiveVehicleNotifier extends Notifier<int?> {
  @override
  int? build() {
    Future.microtask(load);

    return null;
  }

  Future<void> load() async {
    state = await AppPreferences.getActiveVehicle();
  }

  Future<void> setVehicle(int id) async {
    await AppPreferences.setActiveVehicle(id);

    state = id;
  }

  Future<void> clear() async {
    await AppPreferences.clearActiveVehicle();

    state = null;
  }
}
