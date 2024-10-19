import 'package:flutter/material.dart';

class NewPasswordPage extends StatelessWidget {
  NewPasswordPage({super.key});

  final _recoverFormKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();

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

              const SizedBox(height: 46,),

              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nueva Contraseña:',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.left,  
                ),
              ),
              
              const SizedBox(height: 3,),

              TextFormField(
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_sharp,
                    color: Color(0xFF9faed6),  
                  ),
                ),
                controller: _newPasswordController, /////// Cambiarrrrr
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

              const SizedBox(height: 3,),

              TextFormField(
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_sharp,
                    color: Color(0xFF9faed6),  
                  ),
                ),
                controller: _newPasswordController, /////// Cambiarrrrr
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa su contraseña';
                  }
                  return null;
                }, /////// Cambiarrrrr
              ),

              const SizedBox(height: 66),

              ElevatedButton(
                onPressed: () {
                  if (_recoverFormKey.currentState!.validate()) {
                    // Aquí va la lógica para autenticar al usuario
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
                child: const Text('INICIAR SESIÓN'),
              ),

            ],
          )
        ),
      ),
    );
  }
}