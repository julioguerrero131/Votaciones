import 'package:flutter/material.dart';
import 'package:votaciones_movil/routes/app_routes.dart';

class NewPasswordPage extends StatelessWidget {
  NewPasswordPage({super.key});

  final _recoverFormKey = GlobalKey<FormState>();

  final _newPassword1Controller = TextEditingController();
  final _newPassword2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Validar la contraseña
    bool validatePassword() {
      // Contraseñas de longitud mayor a 8
      if (_newPassword1Controller.text.length > 8 &&
          _newPassword1Controller.text.length < 32) {
        if (_newPassword1Controller.text == _newPassword2Controller.text) {
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contraseñas no coinciden.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contraseñas muy corta.')),
          );
      }
      return false;
    }

    // Función para enviar el formulario
    void submitForm() {
      // Formulario valido
      if (_recoverFormKey.currentState!.validate()) {
        final validPassword = validatePassword();
        if (validPassword) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
          // Logica para guardar contraseña
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _recoverFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nueva Contraseña',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Para recuperar su contraseña, escriba el código de seis dígitos que se te envió por correo.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 36,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nueva Contraseña:',
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
                      Icons.lock_sharp,
                      color: Color(0xFF9faed6),
                    ),
                  ),
                  controller: _newPassword1Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa un usuario';
                    }
                    return null;
                  }, /////// Cambiarrrrr
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirmar su Contraseña:',
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
                      Icons.lock_sharp,
                      color: Color(0xFF9faed6),
                    ),
                  ),
                  controller: _newPassword2Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa su contraseña';
                    }
                    return null;
                  }, /////// Cambiarrrrr
                ),
                const SizedBox(height: 66),
                ElevatedButton(
                  onPressed: submitForm,
                  child: const Text('INICIAR SESIÓN'),
                ),
              ],
            )),
      ),
    );
  }
}
