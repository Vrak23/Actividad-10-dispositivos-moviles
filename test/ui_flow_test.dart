import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catalogo_senati/main.dart';

void main() {
  testWidgets('Flujo completo de interacción y navegación SPA', (WidgetTester tester) async {
    await tester.pumpWidget(const CatalogoSenatiApp());
    await tester.pumpAndSettle();

    // 0. Autenticarse en el Login
    expect(find.text('Ingresar al Catálogo'), findsOneWidget);
    await tester.tap(find.text('Ingresar al Catálogo'));
    await tester.pumpAndSettle();
    // Esperar a que el SnackBar de bienvenida se oculte
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    // 1. Verificar carga de elementos iniciales en Home
    expect(find.text('Tarjeta Madre ASUS ROG'), findsOneWidget);
    expect(find.text('Parlantes Profesionales'), findsOneWidget);

    // 2. Probar filtrado por categoría 'Procesadores'
    final processorsChip = find.widgetWithText(ChoiceChip, 'Procesadores');
    expect(processorsChip, findsOneWidget);
    await tester.tap(processorsChip);
    await tester.pumpAndSettle();

    // Debe mostrar Procesador Intel y ocultar Parlantes
    expect(find.text('Procesador Intel Core i7'), findsOneWidget);
    expect(find.text('Parlantes Profesionales'), findsNothing);

    // 3. Volver a 'Todos'
    await tester.tap(find.widgetWithText(ChoiceChip, 'Todos'));
    await tester.pumpAndSettle();
    expect(find.text('Tarjeta Madre ASUS ROG'), findsOneWidget);

    // 4. Probar navegación a la pantalla de detalle al hacer tap en 'Tarjeta Madre ASUS ROG'
    await tester.tap(find.text('Tarjeta Madre ASUS ROG'));
    await tester.pumpAndSettle();

    // Debe estar en DetailScreen
    expect(find.text('Ficha Técnica y Descripción:'), findsOneWidget);
    expect(find.textContaining('ASUS ROG Strix con chipset'), findsOneWidget);
    expect(find.text('Stock disponible en almacén'), findsOneWidget);

    // 5. Presionar 'Volver al Catálogo'
    final backButton = find.widgetWithText(ElevatedButton, 'Volver al Catálogo');
    expect(backButton, findsOneWidget);
    await tester.ensureVisible(backButton);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Debe haber regresado al Home
    expect(find.text('Catálogo SENATI'), findsOneWidget);
    expect(find.text('Nuevo Componente'), findsOneWidget);

    // 6. Abrir modal de registro
    await tester.tap(find.text('Nuevo Componente'));
    await tester.pumpAndSettle();

    expect(find.text('Registrar Nuevo Componente'), findsOneWidget);
    expect(find.text('Guardar Componente'), findsOneWidget);

    // 7. Completar y enviar formulario de registro
    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(3));

    await tester.enterText(textFields.at(0), 'Fuente de Poder 750W');
    await tester.enterText(textFields.at(1), '380.00');
    await tester.enterText(textFields.at(2), 'Certificación 80 Plus Gold con cableado modular.');
    await tester.pumpAndSettle();

    // Guardar
    await tester.tap(find.text('Guardar Componente'));
    await tester.pumpAndSettle();

    // Debe cerrarse el modal y el nuevo componente debe aparecer en el catálogo
    expect(find.text('Registrar Nuevo Componente'), findsNothing);
    expect(find.text('Fuente de Poder 750W'), findsOneWidget);
    expect(find.text('S/ 380.00'), findsOneWidget);
  });
}
