import 'package:flutter/material.dart';
import 'package:votaciones_movil/routes/app_routes.dart';
import 'package:votaciones_movil/screens/actas.dart';
import 'package:votaciones_movil/screens/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    const ActasScreen(),
    const UserProfileScreen(),
  ];

  static final List<String> _screensStr = <String>[
    "Actas",
    "Perfil",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _screensStr[_selectedIndex],
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Aquí colocas la acción para el botón de menú
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Aquí colocas la acción para volver atrás
                Navigator.popAndPushNamed(context, AppRoutes.login);
              },
            ),
          ],
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                backgroundColor: Theme.of(context).primaryColor,
                selectedIconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Reporte',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Perfil',
                  ),
                ],
              ),
            )));
  }
}
