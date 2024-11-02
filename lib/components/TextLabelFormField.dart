import 'package:flutter/material.dart';

class TextLabelFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  const TextLabelFormField({
    super.key,
    required this.controller,
    this.label = 'Texto:',
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 3),
        SizedBox(
          child: TextFormField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.left,
            controller: controller,
            validator: validator,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
