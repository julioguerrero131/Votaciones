import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        leading: const Icon(Icons.notifications_none),
        actions: const [
          Icon(Icons.refresh),
        ],
      ),
      body: SingleChildScrollView(
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
            const Text(
              'Juanito Pérez',
              style: TextStyle(
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
            _buildTextField(label: 'Cédula', initialValue: '0909090909'),
            _buildTextField(label: 'Nombres', initialValue: 'Andrés Santiago'),
            _buildTextField(label: 'Apellidos', initialValue: 'Pérez Sánchez'),
            _buildGenderDropdown(),
            _buildTextField(
                label: 'Dirección domicilio', initialValue: 'Av. Quito 324'),
            _buildDropdownField(label: 'Ciudad', options: ['Guayaquil', 'Quito', 'Cuenca']),
            _buildDropdownField(label: 'Recinto', options: ['Vicente Rocafuerte', 'Otro']),
            _buildTextField(label: 'Teléfono principal', initialValue: '0909090909'),
            _buildTextField(label: 'Teléfono auxiliar', initialValue: '0909090902'),
            _buildImageUploadField(label: 'Documento de identidad', file: _documentFile, isDocument: true),
            _buildImageUploadField(label: 'Carnet delegado', file: _delegateCardFile, isDocument: false),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String initialValue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdownField({required String label, required List<String> options}) {
    String selectedValue = options[0];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items: options
            .map((option) => DropdownMenuItem(value: option, child: Text(option)))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value!;
          });
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    String selectedGender = 'Prefiero no decirlo';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        items: const [
          DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
          DropdownMenuItem(value: 'Femenino', child: Text('Femenino')),
          DropdownMenuItem(
              value: 'Prefiero no decirlo', child: Text('Prefiero no decirlo')),
        ],
        onChanged: (value) {
          setState(() {
            selectedGender = value!;
          });
        },
        decoration: const InputDecoration(
          labelText: 'Género',
          border: OutlineInputBorder(),
        ),
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
              ? ListTile(
                  leading: const Icon(Icons.image),
                  title: Text(file.path.split('/').last),
                  subtitle: Text('${file.lengthSync() / 1024} KB'),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                )
              : TextButton.icon(
                  onPressed: () => _pickImage(isDocument: isDocument),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Tomar una foto'),
                ),
        ],
      ),
    );
  }
}
