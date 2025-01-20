import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votaciones_movil/blocs/reporte_bloc.dart';
import 'package:votaciones_movil/components/numeric_form_field.dart';
import 'package:votaciones_movil/components/dropdown_form_field.dart';
import 'package:votaciones_movil/components/text_label%20_form_field.dart';
import 'package:votaciones_movil/components/show_alert_dialog.dart';
import 'package:votaciones_movil/models/juntas.dart';
import 'package:votaciones_movil/providers/juntas_provider.dart';
import 'package:votaciones_movil/providers/user_provider.dart';
import 'package:votaciones_movil/routes/app_routes.dart';
import 'package:votaciones_movil/services/api_service.dart';
import 'package:votaciones_movil/providers/user_provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _reportKey = GlobalKey<FormState>();
  final ReporteBloc reporteBloc = ReporteBloc(
      ApiService('https://sistema-electoral-cc1y.onrender.com/api'));
  //https://api-observacion-electoral.frative.com/api
  //https://sistema-electoral-cc1y.onrender.com/api

  final _numberTotalVotesController = TextEditingController();
  final _numberValidVotesController = TextEditingController();
  final _numberBlankVotesController = TextEditingController();
  final _numberNullVotesController = TextEditingController();

  List<String> candidatos = [
    'ADN - Daniel Noboa',
    'RC - Luisa Gonzlez',
    'PSC - Henry Kronfle'
  ];

  List<TextEditingController> controllersFirstField = [];
  List<TextEditingController> controllersSecondField = [];

  String? _selectedOption;
  bool _isPresidentChecked = false;
  bool _isSecretaryChecked = false;
  bool _isDelegatedChecked = false;

  int _submitCheckboxAttempt = 0;
  int _submitNumericAttempt = 0;
  int _submitTotalAttempt = 0;

  // Función para enviar el formulario
  void _submitForm() {
    if (_reportKey.currentState!.validate()) {
      // Obtén los valores ingresados en los campos de texto
      int totalVotes = int.tryParse(_numberTotalVotesController.text) ?? 0;
      int validVotes = int.tryParse(_numberValidVotesController.text) ?? 0;
      int blankVotes = int.tryParse(_numberBlankVotesController.text) ?? 0;
      int nullVotes = int.tryParse(_numberNullVotesController.text) ?? 0;

      if (totalVotes < 200 || totalVotes > 310) {
        showAlertDialog(
          context: context,
          title: 'Votos Totales Incorrectos.',
          message:
              'El número de Votos Totales, debe ser MAYOR a 200, y MENOR a 350.',
        );
        return;
      }

      // Calcula la suma de votos válidos, blancos y nulos
      int sumVotes = validVotes + blankVotes + nullVotes;

      // Calcula la suma de los votos ingresados en los campos de texto
      int candidatesVotes = controllersSecondField.fold(0, (sum, controller) {
        int value = int.tryParse(controller.text) ?? 0;
        return sum + value;
      });

      // Validar que la suma coincida con el total
      if (totalVotes != sumVotes) {
        if (_submitTotalAttempt == 0) {
          showAlertDialog(
            context: context,
            title: 'Suma Incorrecta de Votos Totales.',
            message:
                'La suma de los Votos Válidos, Blancos y Nulos no coincide con los Votos Totales.',
          );
          _submitTotalAttempt++;
          return; // No enviamos el formulario si no coinciden
        }
      }

      // Validar el rango de la suma de los votos
      if (candidatesVotes != validVotes) {
        if (_submitNumericAttempt == 0) {
          showAlertDialog(
            context: context,
            title: 'Cantidad Incorrecta de Votos Válidos',
            message:
                'La cantidad de Votos Válidos no coincide con la suma de los Votos de cada Candidatos.',
          );
          _submitNumericAttempt++;
          return; // No enviamos el formulario en el primer intento
        }
      }
    } else {
      showAlertDialog(
        context: context,
        title: 'Campos Faltantes.',
        message: 'Por favor, completa todos los campos correctamente.',
      );
      return;
    }

    // Verificar si al menos un checkbox está marcado
    if (!_isPresidentChecked && !_isSecretaryChecked && !_isDelegatedChecked) {
      // Si es el primer intento sin checkbox, mostrar advertencia
      if (_submitCheckboxAttempt == 0) {
        showAlertDialog(
          context: context,
          title: 'Advertencia: Nadie Firmó las actas.',
          message:
              'No ha marcado ninguna casilla, por lo que indica que ningún miembro de la mesa ha firmado el acta.',
        );
        _submitCheckboxAttempt++;
        return; // No enviamos el formulario en el primer intento
      }
    }

    showAlertDialog(
      context: context,
      title: 'Envío Correcto.',
      message: 'Los datos han sido revisados y enviados.',
    );
    _submitNumericAttempt = 0;
    _submitCheckboxAttempt = 0;

    // Aquí puedes agregar la lógica de envío de datos
  }

  @override
  void initState() {
    super.initState();
    // Inicializamos dos controladores para cada elemento en la lista
    controllersFirstField = List.generate(
        candidatos.length, (index) => TextEditingController(text: candidatos[index]));
    controllersSecondField =
        List.generate(candidatos.length, (index) => TextEditingController());
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
    final user = context.watch<UserProvider>().user;
    final userProvider = Provider.of<UserProvider>(context);
    final juntaProvider = Provider.of<JuntaProvider>(context);

    Future<List<JuntaData>> juntas = reporteBloc.obtenerJuntasPorUsuario(user!.id);

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
                Navigator.pushNamed(context, AppRoutes.main);
              },
            ),
          ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _reportKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ingrese la cantidad de votos según corresponda.",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Divider(
                  color: Color(0xFF18599d), // Cambia el color si lo deseas
                  thickness: 1.0, // Ajusta el grosor de la línea
                  height: 20.0, // Espacio vertical alrededor del Divider
                ),
                FutureBuilder<List<JuntaData>>(
                  future: juntas, // Tu Future<List<String>>
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Mostrar un indicador de carga mientras se resuelve
                    } else if (snapshot.hasError) {
                      return Text(
                          "Error: ${snapshot.error}"); // Mostrar un mensaje de error
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text(
                          "No hay juntas disponibles"); // Mostrar un mensaje cuando no haya datos
                    }
                    // Cuando los datos estén listos, construye el DropdownFormField
                    return DropdownFormField(
                      label: 'Seleccione una junta:',
                      items: snapshot.data!, // Usar los datos resueltos
                      value: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                          JuntaData juntaEscogida = snapshot.data!.firstWhere((junta) => junta.nombre == value);
                          juntaProvider.setJunta(juntaEscogida);
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, seleccione una opción.';
                        }
                        return null;
                      },
                    );
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
                            return 'Por favor, ingrese un número.';
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
                            return 'Por favor, ingrese un número.';
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
                            return 'Por favor, ingrese un número.';
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
                            return 'Por favor, ingrese un número.';
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
                  itemCount: candidatos.length,
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
                                return 'Este campo no puede estar vacío.';
                              }
                              return null;
                            },
                            isReadOnly: true,
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
                                return 'Por favor, ingrese un número.';
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
                      'Firmó Presidente de la JRV.',
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
                      'Firmó Secretaría de la JRV.',
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
                      'Firmaron TODOS los Delegados de la JRV.',
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
