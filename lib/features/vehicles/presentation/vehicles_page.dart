import 'package:flutter/material.dart';

import '../data/vehicle_repository.dart';
import '../models/vehicle.dart';


class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}


class _VehiclesPageState extends State<VehiclesPage> {

  final repository = VehicleRepository();

  late Future<List<Vehicle>> vehicles;


  @override
  void initState() {
    super.initState();

    loadVehicles();
  }


  void loadVehicles() {
    vehicles = repository.getVehicles();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Mis vehículos',
        ),
      ),


      body: FutureBuilder<List<Vehicle>>(

        future: vehicles,

        builder: (context, snapshot) {


          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );

          }


          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text(
                'No hay vehículos registrados',
              ),
            );

          }


          final vehicles = snapshot.data!;


          return ListView.builder(

            padding: const EdgeInsets.all(16),

            itemCount: vehicles.length,


            itemBuilder: (context, index) {

              final vehicle = vehicles[index];


              return Card(

                child: ListTile(

                  title: Text(
                    vehicle.name,
                  ),

                  subtitle: Text(
                    '${vehicle.brand} ${vehicle.model}\n'
                    '${vehicle.year} • ${vehicle.fuelType}',
                  ),

                  isThreeLine: true,

                ),

              );

            },

          );

        },

      ),

    );

  }
}