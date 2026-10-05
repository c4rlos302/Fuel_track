import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.15,
      children: [
        _ActionCard(
          icon: Icons.local_gas_station,
          title: "Registrar",
          color: Colors.green,
          onTap: () {
            context.push('/add-fuel');
          },
        ),

        _ActionCard(
          icon: Icons.history,
          title: "Historial",
          color: Colors.blue,
          onTap: () {
            context.push('/fuel-history');
          },
        ),

        _ActionCard(
          icon: Icons.bar_chart,
          title: "Estadísticas",
          color: Colors.orange,
          onTap: () {
            context.push('/statistics');
          },
        ),

        _ActionCard(
          icon: Icons.directions_car,
          title: "Vehículos",
          color: Colors.purple,
          onTap: () {
            context.push('/vehicles');
          },
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 30, color: color),
              ),

              const SizedBox(height: 12),

              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
