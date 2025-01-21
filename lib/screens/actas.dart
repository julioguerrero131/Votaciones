import 'package:flutter/material.dart';
import 'package:votaciones_movil/blocs/actas_bloc.dart';
import 'package:votaciones_movil/components/acta_card.dart';
import 'package:votaciones_movil/models/proceso_electoral.dart';
import 'package:votaciones_movil/routes/app_routes.dart';
import 'package:votaciones_movil/services/api_service.dart';

class ActasScreen extends StatefulWidget {
  const ActasScreen({super.key});

  @override
  State<ActasScreen> createState() => _ActasScreenState();
}

class _ActasScreenState extends State<ActasScreen> {
  late Future<List<ProcesoElectoralData>> futureActas;
  List<ProcesoElectoralData> _filteredActas = [];

  final ActasBloc actasBloc = ActasBloc(
      ApiService('https://sistema-electoral-cc1y.onrender.com/api'));

  // final List<Map<String, String>> actas = [
  //   {
  //     "title": "Presidente/Vicepresidente",
  //     "date": "Domingo, 14 de julio de 2025",
  //     "route": AppRoutes.reportPresident
  //   },
  //   {
  //     "title": "Asambleísta Provinciales",
  //     "date": "Domingo, 14 de julio de 2025",
  //     "route": AppRoutes.reportPresident
  //   },
  //   {
  //     "title": "Asambleísta Nacionales",
  //     "date": "Domingo, 14 de julio de 2025",
  //     "route": AppRoutes.reportPresident
  //   },
  //   {
  //     "title": "Parlamento Andino",
  //     "date": "Domingo, 14 de julio de 2025",
  //     "route": AppRoutes.reportPresident
  //   },
  //   {
  //     "title": "C.P YASUNÍ",
  //     "date": "Domingo, 14 de julio de 2025",
  //     "route": AppRoutes.reportPresident
  //   },
  //   {
  //     "title": "C.P CHOCO ANDINO",
  //     "date": "Domingo, 14 de julio de 2025",
  //     "route": AppRoutes.reportPresident
  //   },
  // ];


  @override
  void initState() {
    super.initState();
    futureActas = actasBloc.obtenerProcesosElectoralesVigentes();
  }

  void _filterActas(String query) {
    setState(() {
      if (query.isEmpty) {
        futureActas.then((actas) => _filteredActas = actas);
      } else {
        futureActas.then((actas) {
          _filteredActas = actas.where((acta) {
            return acta.nombre.toLowerCase().contains(query.toLowerCase());
          }).toList();
        });
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
              onChanged: _filterActas,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<ProcesoElectoralData>>(
                future: futureActas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay datos disponibles.'));
                  } else {
                    // Mostrar datos
                    _filteredActas = _filteredActas.isEmpty
                        ? snapshot.data!
                        : _filteredActas;
                    return ListView.builder(
                      itemCount: _filteredActas.length,
                      itemBuilder: (context, index) {
                        return ActaCard(
                          title: _filteredActas[index].nombre,
                          date: _filteredActas[index].fecha,
                          route: AppRoutes.reportPresident,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}