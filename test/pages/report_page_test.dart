import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votaciones_movil/screens/report_page.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('ReportPage Widget Tests', () {
    testWidgets('ReportPage should render all initial elements', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: ReportPage()));

      // Assert - Verify all main components are rendered
      expect(find.text('Informe'), findsOneWidget);
      expect(find.text('Ingrese la cantidad de votos según corresponda.'), findsOneWidget);
      expect(find.text('Seleccione una junta:'), findsOneWidget);
      
      // Verify numeric fields
      expect(find.text('Totales:'), findsOneWidget);
      expect(find.text('Válidos:'), findsOneWidget);
      expect(find.text('Blancos:'), findsOneWidget);
      expect(find.text('Nulos:'), findsOneWidget);

      // Verify candidate fields
      expect(find.text('ADN - Daniel Noboa'), findsOneWidget);
      expect(find.text('RC - Luisa Gonzlez'), findsOneWidget);
      expect(find.text('PSC - Henry Kronfle'), findsOneWidget);

      // Verify checkboxes
      expect(find.text('Firmó Presidente de la JRV.'), findsOneWidget);
      expect(find.text('Firmó Secretaría de la JRV.'), findsOneWidget);
      expect(find.text('Firmaron TODOS los Delegados de la JRV.'), findsOneWidget);

      // Verify submit button
      expect(find.text('Guardar Datos y Enviar'), findsOneWidget);
    });

    testWidgets('Should show validation errors when submitting empty form', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: ReportPage()));

      // Act
      await tester.tap(find.text('Guardar Datos y Enviar'));
      await tester.pump();

      // Assert
      expect(find.text('Por favor, seleccione una opción.'), findsOneWidget);
      expect(find.text('Por favor, ingrese un número.'), findsAtLeastNWidgets(1));
    });

    testWidgets('Should validate total votes range', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: ReportPage()));

      // Fill form with invalid total votes (less than 200)
      await tester.enterText(find.widgetWithText(TextFormField, 'Totales:'), '150');
      
      // Act
      await tester.tap(find.text('Guardar Datos y Enviar'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Votos Totales Incorrectos.'), findsOneWidget);
      expect(
        find.text('El número de Votos Totales, debe ser MAYOR a 200, y MENOR a 350.'),
        findsOneWidget
      );
    });

    testWidgets('Should validate votes sum matches total', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: ReportPage()));

      // Fill form with mismatching votes
      await tester.enterText(find.widgetWithText(TextFormField, 'Totales:'), '250');
      await tester.enterText(find.widgetWithText(TextFormField, 'Válidos:'), '100');
      await tester.enterText(find.widgetWithText(TextFormField, 'Blancos:'), '50');
      await tester.enterText(find.widgetWithText(TextFormField, 'Nulos:'), '50');

      // Act
      await tester.tap(find.text('Guardar Datos y Enviar'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Suma Incorrecta de Votos Totales.'), findsOneWidget);
      expect(
        find.text('La suma de los Votos Válidos, Blancos y Nulos no coincide con los Votos Totales.'),
        findsOneWidget
      );
    });

    testWidgets('Should validate candidates votes sum matches valid votes', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: ReportPage()));

      // Fill main votes
      await tester.enterText(find.widgetWithText(TextFormField, 'Totales:'), '250');
      await tester.enterText(find.widgetWithText(TextFormField, 'Válidos:'), '200');
      await tester.enterText(find.widgetWithText(TextFormField, 'Blancos:'), '25');
      await tester.enterText(find.widgetWithText(TextFormField, 'Nulos:'), '25');

      // Fill candidate votes that don't sum to valid votes
      final candidateVotesFields = find.widgetWithText(TextFormField, 'Votos:');
      await tester.enterText(candidateVotesFields.at(0), '50');
      await tester.enterText(candidateVotesFields.at(1), '50');
      await tester.enterText(candidateVotesFields.at(2), '50');

      // Act
      await tester.tap(find.text('Guardar Datos y Enviar'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Cantidad Incorrecta de Votos Válidos'), findsOneWidget);
      expect(
        find.text('La cantidad de Votos Válidos no coincide con la suma de los Votos de cada Candidatos.'),
        findsOneWidget
      );
    });

    testWidgets('Should show warning when no checkboxes are checked', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: ReportPage()));

      // Fill valid form data but leave checkboxes unchecked
      await tester.enterText(find.widgetWithText(TextFormField, 'Totales:'), '250');
      await tester.enterText(find.widgetWithText(TextFormField, 'Válidos:'), '200');
      await tester.enterText(find.widgetWithText(TextFormField, 'Blancos:'), '25');
      await tester.enterText(find.widgetWithText(TextFormField, 'Nulos:'), '25');

      final candidateVotesFields = find.widgetWithText(TextFormField, 'Votos:');
      await tester.enterText(candidateVotesFields.at(0), '100');
      await tester.enterText(candidateVotesFields.at(1), '50');
      await tester.enterText(candidateVotesFields.at(2), '50');

      // Select a junta
      await tester.tap(find.text('Seleccione una junta:'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Junta 1').last);
      await tester.pumpAndSettle();

      // Act
      await tester.tap(find.text('Guardar Datos y Enviar'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Advertencia: Nadie Firmó las actas.'), findsOneWidget);
      expect(
        find.text('No ha marcado ninguna casilla, por lo que indica que ningún miembro de la mesa ha firmado el acta.'),
        findsOneWidget
      );
    });

    testWidgets('Should submit successfully with valid data', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: ReportPage()));

      // Fill all required fields with valid data
      await tester.enterText(find.widgetWithText(TextFormField, 'Totales:'), '250');
      await tester.enterText(find.widgetWithText(TextFormField, 'Válidos:'), '200');
      await tester.enterText(find.widgetWithText(TextFormField, 'Blancos:'), '25');
      await tester.enterText(find.widgetWithText(TextFormField, 'Nulos:'), '25');

      final candidateVotesFields = find.widgetWithText(TextFormField, 'Votos:');
      await tester.enterText(candidateVotesFields.at(0), '100');
      await tester.enterText(candidateVotesFields.at(1), '50');
      await tester.enterText(candidateVotesFields.at(2), '50');

      // Select a junta
      await tester.tap(find.text('Seleccione una junta:'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Junta 1').last);
      await tester.pumpAndSettle();

      // Check at least one checkbox
      await tester.tap(find.widgetWithText(Checkbox, 'Firmó Presidente de la JRV.'));
      await tester.pump();

      // Act
      await tester.tap(find.text('Guardar Datos y Enviar'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Envío Correcto.'), findsOneWidget);
      expect(find.text('Los datos han sido revisados y enviados.'), findsOneWidget);
    });
  });
}