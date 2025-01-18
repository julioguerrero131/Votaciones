import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votaciones_movil/providers/juntas_provider.dart';
import 'package:votaciones_movil/providers/user_provider.dart';
import 'package:votaciones_movil/routes/app_routes.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => JuntaProvider()),
    ],
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.getRoutes(),
      theme: ThemeData(
        primaryColor: const Color(0xFF18599d),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color(0xFF18599d)),
          titleTextStyle: TextStyle(color: Color(0xFF18599d), fontSize: 20),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF18599d), // Color de fondo
            foregroundColor: Colors.white,
            textStyle:
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
            padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 25),
          ),
        ),
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            color: Color(0xFF18599d),
          ),
          labelSmall: TextStyle(
            color: Color(0xFF18599d),
          ),
          headlineSmall: TextStyle(
            color: Color(0xFF18599d),
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFF9ab4d1),
          ),
          bodySmall: TextStyle(
            color: Color(0xFF9ab4d1),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Color(0xFFe9e7ff),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Color(0xFFC3BDFF),
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Color(0xFFe9e7ff),
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Color(0xFFC3BDFF),
              width: 1.0,
            ),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90.0),
          ),
          fillColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const Color(
                    0xFFf43195); // color cuando está seleccionado
              }
              return null; // color por defecto cuando no está seleccionado
            },
          ),

          checkColor: WidgetStateProperty.all(Colors.white), // color del check
        ),
      ),
    );
  }
}
