import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  const NumericFormField({
    super.key,
    required this.controller,
    this.label = 'Número:',
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
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
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
