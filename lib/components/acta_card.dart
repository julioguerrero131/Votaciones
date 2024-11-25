import 'package:flutter/material.dart';
import 'package:votaciones_movil/routes/app_routes.dart';

class ActaCard extends StatelessWidget {
  final String title;
  final String date;
  final String route;

  const ActaCard({
    super.key,
    required this.title,
    required this.date,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.reportPresident);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: const Icon(Icons.people, size: 40, color: Colors.blue),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(date),
        ),
      ),
    );
  }
}
