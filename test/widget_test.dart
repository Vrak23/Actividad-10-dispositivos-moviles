import 'package:flutter_test/flutter_test.dart';
import 'package:catalogo_senati/main.dart';

void main() {
  testWidgets('Carga inicial del Catálogo SENATI smoke test', (WidgetTester tester) async {
    // Construir la aplicación
    await tester.pumpWidget(const CatalogoSenatiApp());
    await tester.pumpAndSettle();

    // Iniciar sesión desde la pantalla de Login
    expect(find.text('Ingresar al Catálogo'), findsOneWidget);
    await tester.tap(find.text('Ingresar al Catálogo'));
    await tester.pumpAndSettle();

    // Verificar que el título institucional y los filtros aparezcan en Home
    expect(find.text('Catálogo SENATI'), findsOneWidget);
    expect(find.text('Todos'), findsOneWidget);
    expect(find.text('Hardware'), findsWidgets);
    expect(find.text('Nuevo Componente'), findsOneWidget);
  });
}
