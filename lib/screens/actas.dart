import 'package:flutter/material.dart';
import 'package:votaciones_movil/components/acta_card.dart';
import 'package:votaciones_movil/routes/app_routes.dart';

class ActasScreen extends StatelessWidget {
  final List<Map<String, String>> actas = [
    {
      "title": "Presidente/Vicepresidente", 
      "date": "Domingo, 14 de julio de 2025", 
      "route": AppRoutes.reportPresident
    }, {
      "title": "Asambleísta Provinciales", 
      "date": "Domingo, 14 de julio de 2025",
      "route": AppRoutes.reportPresident
    }, {
      "title": "Asambleísta Nacionales", 
      "date": "Domingo, 14 de julio de 2025",
      "route": AppRoutes.reportPresident
    }, {
      "title": "Parlamento Andino", 
      "date": "Domingo, 14 de julio de 2025",
      "route": AppRoutes.reportPresident
    }, {
      "title": "C.P YASUNÍ", 
      "date": "Domingo, 14 de julio de 2025",
      "route": AppRoutes.reportPresident
    }, {
      "title": "C.P CHOCO ANDINO", 
      "date": "Domingo, 14 de julio de 2025",
      "route": AppRoutes.reportPresident
    },
  ];

  ActasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: actas.length,
                itemBuilder: (context, index) {
                  return ActaCard(
                    title: actas[index]["title"]!,
                    date: actas[index]["date"]!,
                    route: actas[index]["route"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}