import 'package:flutter/material.dart';
import 'package:votaciones_movil/models/juntas.dart';

class DropdownFormField extends StatelessWidget {
  final String label;
  final List<JuntaData> items;
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const DropdownFormField({
    super.key,
    required this.label,
    required this.items,

    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 3),
        DropdownButtonFormField<String>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xFFffffff),
          ),
          items: items.map((JuntaData item) {
            return DropdownMenuItem<String>(
              value: item.nombre,
              child: Text(
                item.nombre,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
