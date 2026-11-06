import 'package:flutter/material.dart';

/// Modelo de datos para representar un componente de hardware en el catálogo.
class HardwareComponent {
  final String id;
  final String name;
  final String category;
  final double price;
  final String technicalDescription;
  final String stockStatus;
  final int stockCount;

  const HardwareComponent({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.technicalDescription,
    this.stockStatus = 'Stock disponible en almacén',
    this.stockCount = 50,
  });

  /// Retorna un ícono representativo según la categoría del componente.
  IconData get categoryIcon {
    switch (category.toLowerCase()) {
      case 'hardware':
        return Icons.developer_board_rounded;
      case 'procesadores':
        return Icons.memory_rounded;
      case 'almacenamiento':
        return Icons.storage_rounded;
      case 'periféricos':
      case 'perifericos':
        return Icons.keyboard_alt_outlined;
      default:
        return Icons.devices_other_rounded;
    }
  }

  /// Retorna un color de etiqueta distintivo para la categoría.
  Color get categoryBadgeColor {
    switch (category.toLowerCase()) {
      case 'hardware':
        return const Color(0xFF2563EB); // Azul
      case 'procesadores':
        return const Color(0xFF7C3AED); // Púrpura
      case 'almacenamiento':
        return const Color(0xFFD97706); // Ámbar
      case 'periféricos':
      case 'perifericos':
        return const Color(0xFF0D9488); // Teal
      default:
        return const Color(0xFF4B5563);
    }
  }

  HardwareComponent copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    String? technicalDescription,
    String? stockStatus,
    int? stockCount,
  }) {
    return HardwareComponent(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      technicalDescription: technicalDescription ?? this.technicalDescription,
      stockStatus: stockStatus ?? this.stockStatus,
      stockCount: stockCount ?? this.stockCount,
    );
  }
}
