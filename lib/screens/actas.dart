import 'package:flutter/material.dart';
import 'package:votaciones_movil/components/acta_card.dart';
import 'package:votaciones_movil/routes/app_routes.dart';

class ActasScreen extends StatefulWidget {
  const ActasScreen({super.key});

  @override
  State<ActasScreen> createState() => _ActasScreenState();
}

class _ActasScreenState extends State<ActasScreen> {
  final List<Map<String, String>> actas = [
    {
      "title": "Presidente/Vicepresidente",
      "date": "Domingo, 14 de julio de 2025",
      "route": AppRoutes.reportPresident
    },
    {
      "title": "Asambleísta Provinciales",
      "date": "Domingo, 14 de julio de 2025",
      "route": AppRoutes.reportPresident
    },
    {
      "title": "Asambleísta Nacionales",
      "date": "Domingo, 14 de julio de 2025",
      "route": AppRoutes.reportPresident
    },
    {
      "title": "Parlamento Andino",
      "date": "Domingo, 14 de julio de 2025",
      "route": AppRoutes.reportPresident
    },
    {
      "title": "C.P YASUNÍ",
      "date": "Domingo, 14 de julio de 2025",
      "route": AppRoutes.reportPresident
    },
    {
      "title": "C.P CHOCO ANDINO",
      "date": "Domingo, 14 de julio de 2025",
      "route": AppRoutes.reportPresident
    },
  ];

  // Lista filtrada
  List<Map<String, String>> _filteredActas = [];

  @override
  void initState() {
    super.initState();
    _filteredActas = actas; // Inicializar con todas las actas
  }

  void _filterActas(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredActas = actas; // Mostrar todas si la búsqueda está vacía
      } else {
        _filteredActas = actas.where((acta) {
          return acta["title"]!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

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
              onChanged: _filterActas, // Llamar a la función de filtrado
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredActas.length, // Usar la lista filtrada
                itemBuilder: (context, index) {
                  return ActaCard(
                    title: _filteredActas[index]["title"]!,
                    date: _filteredActas[index]["date"]!,
                    route: _filteredActas[index]["route"]!,
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