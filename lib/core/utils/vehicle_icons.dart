import 'package:flutter/material.dart';

IconData getVehicleIcon(String? type) {
  switch (type) {
    case "Moto":
      return Icons.two_wheeler;

    case "Camioneta":
      return Icons.directions_car_filled;

    case "Camion":
      return Icons.local_shipping;

    case "Electrico":
      return Icons.electric_car;

    default:
      return Icons.directions_car;
  }
}
