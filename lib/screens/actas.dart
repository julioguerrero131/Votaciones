import 'package:flutter/material.dart';

class ActasScreen extends StatelessWidget {
  final List<Map<String, String>> actas = [
    {"title": "Presidente/Vicepresidente", "date": "Domingo, 14 de julio de 2025"},
    {"title": "Asambleísta Provinciales", "date": "Domingo, 14 de julio de 2025"},
    {"title": "Asambleísta Nacionales", "date": "Domingo, 14 de julio de 2025"},
    {"title": "Parlamento Andino", "date": "Domingo, 14 de julio de 2025"},
    {"title": "C.P YASUNÍ", "date": "Domingo, 14 de julio de 2025"},
    {"title": "C.P CHOCO ANDINO", "date": "Domingo, 14 de julio de 2025"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actas'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: actas.length,
                itemBuilder: (context, index) {
                  return ActaCard(
                    title: actas[index]["title"]!,
                    date: actas[index]["date"]!,
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

class ActaCard extends StatelessWidget {
  final String title;
  final String date;

  ActaCard({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.people, size: 40, color: Colors.blue),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
      ),
    );
  }
}
