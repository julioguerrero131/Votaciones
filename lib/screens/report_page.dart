import 'package:flutter/material.dart';
import 'package:votaciones_movil/components/NumericFormField.dart';
import 'package:votaciones_movil/components/DropDownFormField.dart';
import 'package:votaciones_movil/components/TextLabelFormField.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _reportKey = GlobalKey<FormState>();

  final _numberTotalVotesController = TextEditingController();
  final _numberValidVotesController = TextEditingController();
  final _numberBlankVotesController = TextEditingController();
  final _numberNullVotesController = TextEditingController();

  List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  List<TextEditingController> controllersFirstField = [];
  List<TextEditingController> controllersSecondField = [];

  String? _selectedOption;
  bool _isPresidentChecked = false;
  bool _isSecretaryChecked = false;
  bool _isDelegatedChecked = false;

  // Función para enviar el formulario
  void _submitForm() {
    if (_reportKey.currentState!.validate()) {
      // Si el formulario es válido, realiza la acción de login
      print('Formulario válido');
      // Aquí puedes agregar la lógica de autenticación
    } else {
      print('Formulario no válido');
    }
  }

  @override
  void initState() {
    super.initState();
    // Inicializamos dos controladores para cada elemento en la lista
    controllersFirstField =
        List.generate(items.length, (index) => TextEditingController());
    controllersSecondField =
        List.generate(items.length, (index) => TextEditingController());
  }

  @override
  void dispose() {
    // Liberar los controladores usando un bucle for
    for (int i = 0; i < controllersFirstField.length; i++) {
      controllersFirstField[i].dispose();
      controllersSecondField[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informe",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _reportKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ingrese la cantidad de votos según corresponda",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Divider(
                  color: Color(0xFF18599d), // Cambia el color si lo deseas
                  thickness: 1.0, // Ajusta el grosor de la línea
                  height: 20.0, // Espacio vertical alrededor del Divider
                ),
                DropdownFormField(
                  label: 'Seleccione una junta:',
                  items: const ['Junta 1', 'Junta 2', 'Junta 3'],
                  value: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, seleccione una opción';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: NumericFormField(
                        controller: _numberTotalVotesController,
                        label: 'Totales:',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese un número';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: NumericFormField(
                        controller: _numberValidVotesController,
                        label: 'Válidos:',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese un número';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: NumericFormField(
                        controller: _numberBlankVotesController,
                        label: 'Blancos:',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese un número';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: NumericFormField(
                        controller: _numberNullVotesController,
                        label: 'Nulos:',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese un número';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap:
                      true, // Esto le dice al ListView que no ocupe todo el espacio disponible
                  physics:
                      const NeverScrollableScrollPhysics(), // Evita que el ListView intente hacer scroll dentro de SingleChildScrollView
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextLabelFormField(
                            controller: controllersFirstField[
                                index], // Cambiado para usar un controlador diferente por cada elemento
                            label: 'Candidato:',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo no puede estar vacío';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: NumericFormField(
                            controller: controllersSecondField[
                                index], // Cambiado para usar un controlador diferente por cada elemento
                            label: 'Votos:',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese un número';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isPresidentChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isPresidentChecked = value!;
                        });
                      },
                    ),
                    Text(
                      'Firmó Presidente de la JRV',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isSecretaryChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isSecretaryChecked = value!;
                        });
                      },
                    ),
                    Text(
                      'Firmó Secretaría de la JRV',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isDelegatedChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isDelegatedChecked = value!;
                        });
                      },
                    ),
                    Text(
                      'Firmaron TODOS los Delegados de la JRV',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Guardar Datos y Enviar'),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
