import 'package:flutter/material.dart';

class RecoverAccountPage extends StatelessWidget {
  RecoverAccountPage({super.key});

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
                    'Recuperar Cuenta',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 5,),
                Text(
                  'Para recuperar su contraseña, escriba el correo con el que se registró para enviarle un mail de recuperación.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 36,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Correo:',
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
                      Icons.mail_outline_outlined,
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
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      Navigator.pushNamed(context, '/recover_code');
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
