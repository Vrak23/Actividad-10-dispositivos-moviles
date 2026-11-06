import 'package:flutter/material.dart';
import '../data/mock_components.dart';
import '../models/hardware_component.dart';

/// Controlador modular para la gestión de estado del catálogo SENATI.
class CatalogController extends ChangeNotifier {
  final List<HardwareComponent> _components = List.from(initialMockComponents);
  String _selectedCategory = CatalogCategories.all;
  String _searchQuery = '';
  bool _isSearchActive = false;

  // Getters
  List<HardwareComponent> get allComponents => List.unmodifiable(_components);
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get isSearchActive => _isSearchActive;

  /// Retorna los componentes filtrados por categoría activa y texto de búsqueda.
  List<HardwareComponent> get filteredComponents {
    return _components.where((item) {
      final matchesCategory = _selectedCategory == CatalogCategories.all ||
          item.category.toLowerCase() == _selectedCategory.toLowerCase();

      final matchesSearch = _searchQuery.isEmpty ||
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.technicalDescription.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.category.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  /// Cambia la categoría activa de filtrado.
  void setCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  /// Actualiza el query de búsqueda de texto.
  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  /// Activa o desactiva la barra de búsqueda en el AppBar.
  void toggleSearch() {
    _isSearchActive = !_isSearchActive;
    if (!_isSearchActive) {
      _searchQuery = '';
    }
    notifyListeners();
  }

  /// Añade un nuevo componente a la lista e informa a los listeners.
  void addComponent(HardwareComponent component) {
    _components.insert(0, component);
    notifyListeners();
  }
}
