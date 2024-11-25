import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:votaciones_movil/routes/app_routes.dart';

class RecoverCodePage extends StatelessWidget {
  RecoverCodePage({super.key});

  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ingrese el código',
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
                    'Código de Recuperación:',
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.numbers_outlined,
                      color: Color(0xFF9faed6),
                    ),
                  ),
                  controller: _emailController, /////// Cambiarrrrr
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa un correo';
                    }
                    return null;
                  }, /////// Cambiarrrrr
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        // reenvio de codigo
                      },
                      child: Text(
                        'Reenviar código',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.right,
                      ),
                    )),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      Navigator.pushNamed(context, AppRoutes.newPassword);
                      // Aquí va la lógica para autenticar al usuarios
                    }
                  },
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: const Color(0xFF383ea5), // Color de fondo del botón
                  //   foregroundColor: Colors.white,      // Color del texto del botón
                  //   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Tamaño del padding interno
                  //   textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w100, letterSpacing: BorderSide.strokeAlignInside), // Estilo del texto
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20), // Bordes redondeados
                  //   ),
                  // ),
                  child: const Text('ENVIAR'),
                ),
              ],
            )),
      ),
    );
  }
}
