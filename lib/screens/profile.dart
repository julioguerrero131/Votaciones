import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:votaciones_movil/components/image_viewer.dart';
import 'package:votaciones_movil/components/numeric_form_field.dart';
import 'dart:io';

import 'package:votaciones_movil/components/text_label%20_form_field.dart';
import 'package:votaciones_movil/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File? _documentFile;
  File? _delegateCardFile;
  final ImagePicker _picker = ImagePicker();


  Future<void> _pickImage({required bool isDocument}) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        if (isDocument) {
          _documentFile = File(pickedFile.path);
        } else {
          _delegateCardFile = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    final idNumberController = TextEditingController(text: user?.cedula);
    final namesController = TextEditingController(text: user?.nombres);
    final lastNamesController = TextEditingController(text: user?.apellidos);
    final genderController = TextEditingController(text: user?.genero);
    final homeAddressController = TextEditingController(text: user?.direccion);
    final firstNumberController = TextEditingController(text: user?.telefono);
    final auxiliarNumberController = TextEditingController(text: user?.telefonoAux);
    final name = user?.nombres ?? 'Nombre no disponible';

    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade800,
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Cargo',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            TextLabelFormField(
              controller: idNumberController,
              label: "Cedula",
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, seleccione una opción';
                  }
                  return null;
              },
              isReadOnly: true
            ),
            TextLabelFormField(
              controller: namesController,
              label: "Nombres:",
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, seleccione una opción';
                  }
                  return null;
              },
              isReadOnly: true
            ),
            TextLabelFormField(
              controller: lastNamesController,
              label: "Apellidos:",
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, seleccione una opción';
                  }
                  return null;
              },
              isReadOnly: true
            ),
            TextLabelFormField(
              controller: genderController,
              label: "Genero:",
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, seleccione una opción';
                  }
                  return null;
              },
              isReadOnly: true
            ),
            TextLabelFormField(
              controller: homeAddressController,
              label: "Dirección domicilio:",
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, seleccione una opción';
                  }
                  return null;
              },
              isReadOnly: true
            ),
            NumericFormField(
              controller: firstNumberController,
              label: 'Teléfono principal:',
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, seleccione una opción';
                  }
                  return null;
              },
              isReadOnly: true
            ),
            NumericFormField(
              controller: auxiliarNumberController,
              label: 'Teléfono principal:',
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, seleccione una opción';
                  }
                  return null;
              },
              isReadOnly: true
            ),
            _buildImageUploadField(label: 'Documento de identidad', file: _documentFile, isDocument: true),
            _buildImageUploadField(label: 'Carnet delegado', file: _delegateCardFile, isDocument: false),
            const SizedBox(height: 10)
          ],
        ),
      );
  }


  Widget _buildImageUploadField({required String label, File? file, required bool isDocument}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        file != null
            ? InkWell( // Usamos InkWell para detectar el tap y dar feedback visual
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewer(file: file), // Navegamos a un visor
                    ),
                  );
                },
                child: ListTile(
                  leading: const Icon(Icons.image),
                  title: Text(file.path.split('/').last),
                  subtitle: Text('${file.lengthSync() / 1024} KB'),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                ),
              )
            : TextButton.icon(
                onPressed: () => _pickImage(isDocument: isDocument),
                icon: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(
                  'Tomar una foto',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
      ],
    ),
  );
}
}
