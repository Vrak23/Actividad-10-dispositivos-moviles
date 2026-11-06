import 'package:flutter_test/flutter_test.dart';
import 'package:catalogo_senati/data/mock_components.dart';
import 'package:catalogo_senati/models/hardware_component.dart';
import 'package:catalogo_senati/state/catalog_controller.dart';
import 'package:catalogo_senati/utils/formatters.dart';

void main() {
  group('Formatters Tests', () {
    test('Formatea números a moneda peruana (S/.) con comas y decimales', () {
      expect(Formatters.formatCurrency(1250.00), 'S/ 1,250.00');
      expect(Formatters.formatCurrency(50.00), 'S/ 50.00');
      expect(Formatters.formatCurrency(1680.50), 'S/ 1,680.50');
      expect(Formatters.formatCurrency(0.00), 'S/ 0.00');
    });
  });

  group('CatalogController Tests', () {
    late CatalogController controller;

    setUp(() {
      controller = CatalogController();
    });

    test('Inicializa con datos mock y filtro en Todos', () {
      expect(controller.selectedCategory, CatalogCategories.all);
      expect(controller.filteredComponents.length, initialMockComponents.length);
    });

    test('Filtra correctamente por categoría Hardware', () {
      controller.setCategory(CatalogCategories.hardware);
      expect(controller.selectedCategory, CatalogCategories.hardware);

      for (final item in controller.filteredComponents) {
        expect(item.category, CatalogCategories.hardware);
      }
    });

    test('Filtra correctamente por término de búsqueda', () {
      controller.setSearchQuery('Intel');
      expect(controller.filteredComponents.length, 1);
      expect(controller.filteredComponents.first.name, contains('Intel Core i7'));
    });

    test('Permite agregar un nuevo componente y lo ubica al inicio de la lista', () {
      const newComp = HardwareComponent(
        id: 'TEST-001',
        name: 'Teclado Mecánico RGB',
        category: CatalogCategories.peripherals,
        price: 180.00,
        technicalDescription: 'Switches mecánicos táctiles con iluminación RGB.',
      );

      final initialCount = controller.allComponents.length;
      controller.addComponent(newComp);

      expect(controller.allComponents.length, initialCount + 1);
      expect(controller.filteredComponents.first.name, 'Teclado Mecánico RGB');
    });
  });
}
