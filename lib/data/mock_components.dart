import '../models/hardware_component.dart';

/// Categorías oficiales para el filtrado y registro en el Catálogo SENATI.
class CatalogCategories {
  static const String all = 'Todos';
  static const String hardware = 'Hardware';
  static const String processors = 'Procesadores';
  static const String storage = 'Almacenamiento';
  static const String peripherals = 'Periféricos';

  static const List<String> filterList = [
    all,
    hardware,
    processors,
    storage,
    peripherals,
  ];

  static const List<String> formList = [
    hardware,
    processors,
    storage,
    peripherals,
  ];
}

/// Datos iniciales simulados del laboratorio de TI.
final List<HardwareComponent> initialMockComponents = [
  const HardwareComponent(
    id: 'COMP-001',
    name: 'Tarjeta Madre ASUS ROG',
    category: CatalogCategories.hardware,
    price: 1250.00,
    technicalDescription:
        'Tarjeta madre gaming ASUS ROG Strix con chipset de alto rendimiento, soporte para overclocking, múltiples ranuras M.2 NVMe PCIe 4.0 y disipadores térmicos integrados.',
    stockStatus: 'Stock disponible en almacén',
    stockCount: 12,
  ),
  const HardwareComponent(
    id: 'COMP-002',
    name: 'Procesador Intel Core i7',
    category: CatalogCategories.processors,
    price: 1680.00,
    technicalDescription:
        'Procesador de 12 núcleos y 20 hilos con arquitectura híbrida de rendimiento, frecuencia turbo de hasta 4.9 GHz y caché Intel Smart de 25MB para tareas intensivas.',
    stockStatus: 'Stock disponible en almacén',
    stockCount: 8,
  ),
  const HardwareComponent(
    id: 'COMP-003',
    name: 'Memoria RAM 16GB DDR4',
    category: CatalogCategories.storage,
    price: 240.00,
    technicalDescription:
        'Módulo de memoria RAM DDR4 de 16GB a 3200MHz con disipador de aluminio anodizado de bajo perfil y compatibilidad certificada con perfiles XMP 2.0.',
    stockStatus: 'Stock disponible en almacén',
    stockCount: 35,
  ),
  const HardwareComponent(
    id: 'COMP-004',
    name: 'Monitor Gamer 27" 144Hz',
    category: CatalogCategories.peripherals,
    price: 990.00,
    technicalDescription:
        'Monitor IPS de 27 pulgadas con resolución Full HD, tasa de refresco ultra fluida de 144Hz, tiempo de respuesta de 1ms y tecnología FreeSync/G-Sync compatible.',
    stockStatus: 'Stock disponible en almacén',
    stockCount: 15,
  ),
  const HardwareComponent(
    id: 'COMP-005',
    name: 'Parlantes Profesionales',
    category: CatalogCategories.peripherals,
    price: 50.00,
    technicalDescription:
        'Parlantes profesionales con calidad Blooto, conectividad inalámbrica de baja latencia, sonido envolvente estéreo y controles de ecualización directos.',
    stockStatus: 'Stock disponible en almacén',
    stockCount: 50,
  ),
];
