// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:votaciones_movil/blocs/login_bloc.dart';
import 'package:votaciones_movil/routes/app_routes.dart';
import 'package:votaciones_movil/models/users_data.dart';
import 'package:votaciones_movil/services/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;

  final LoginBloc loginBloc = LoginBloc(ApiService('https://sistema-electoral-cc1y.onrender.com/api/'));

  void _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final user = await loginBloc.login(username, password);
    if (user.isNotEmpty) {
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos.')),
      );
      print(user.isNotEmpty);
      print(user.cedula);
    }
  }


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Función para validar usuario
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa un nombre de usuario';
    }
    if (value.length < 4) {
      return 'El nombre de usuario debe tener al menos 4 caracteres';
    }
    return null;
  }

  // Función para validar contraseña
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa una contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  // Función para enviar el formulario
  void _submitForm() {
    if (_loginFormKey.currentState!.validate()) {
      // Si el formulario es válido, realiza la acción de login
      // Aquí puedes agregar la lógica de autenticación

      Navigator.pushReplacementNamed(context, AppRoutes.main);
    } else {
      // No inicia sesion
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   onPressed: () {
        //     // Aquí colocas la acción para el botón de menú
        //   },
        // ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: () {
        //       // Aquí colocas la acción para volver atrás
        //       Navigator.pop(context);
        //     },
        //   ),
        // ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'BIENVENIDO!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Icon(
                          Icons.account_circle_outlined,
                          color: Color(0xFFfa0093),
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Inicio de Sesión',
                          style: TextStyle(
                            color: Color(0xFF18599d),
                            fontSize: 20,
                          ),
                        )
                      ]),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Usuario:',
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: Color(0xFF9faed6),
                      ),
                    ),
                    controller: _usernameController,
                    validator: _validateUsername,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Contraseña:',
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_sharp,
                        color: Color(0xFF9faed6),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Cambia el icono dependiendo de si la contraseña está visible o no
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          // Cambiar el estado para mostrar/ocultar la contraseña
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        color: const Color(0xFF9faed6),
                      ),
                    ),
                    controller: _passwordController,
                    validator: _validatePassword,
                    obscureText: !_passwordVisible,
                  ),
                  const SizedBox(height: 16),
                  Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/recover_account');
                        },
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: Theme.of(context).textTheme.labelSmall,
                          textAlign: TextAlign.right,
                        ),
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text('INICIAR SESIÓN'),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
