import 'package:flutter/material.dart';
import '../../data/mock_components.dart';
import '../../models/hardware_component.dart';
import '../../theme/app_theme.dart';

/// Modal emergente para registrar un nuevo componente de hardware.
class RegisterComponentModal extends StatefulWidget {
  final Function(HardwareComponent) onSave;

  const RegisterComponentModal({
    super.key,
    required this.onSave,
  });

  /// Muestra el modal como un BottomSheet estilizado y adaptativo.
  static Future<void> show(
    BuildContext context, {
    required Function(HardwareComponent) onSave,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RegisterComponentModal(onSave: onSave),
    );
  }

  @override
  State<RegisterComponentModal> createState() => _RegisterComponentModalState();
}

class _RegisterComponentModalState extends State<RegisterComponentModal> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = CatalogCategories.formList.first;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Limpiar texto de precio por si el usuario incluyó 'S/' o comas
      final cleanPriceStr = _priceController.text
          .replaceAll('S/', '')
          .replaceAll('S/.', '')
          .replaceAll(',', '')
          .trim();

      final parsedPrice = double.tryParse(cleanPriceStr) ?? 0.0;

      final newComponent = HardwareComponent(
        id: 'COMP-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        name: _nameController.text.trim(),
        category: _selectedCategory,
        price: parsedPrice,
        technicalDescription: _descriptionController.text.trim(),
        stockStatus: 'Stock disponible en almacén',
        stockCount: 20,
      );

      widget.onSave(newComponent);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Componente "${newComponent.name}" registrado con éxito.',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.emeraldPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: bottomInset + 24,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Barra de arrastre superior
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Encabezado del modal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Registrar Nuevo Componente',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    color: AppColors.textSecondary,
                    tooltip: 'Cerrar',
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Campo 1: Nombre del Componente
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Componente',
                  hintText: 'Ej. Tarjeta de Video RTX 4070',
                  prefixIcon: Icon(Icons.laptop_chromebook_rounded),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el nombre del componente';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Campo 2: Categoría (Dropdown)
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  prefixIcon: Icon(Icons.account_tree_outlined),
                ),
                items: CatalogCategories.formList.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 14),

              // Campo 3: Precio
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Precio (Ej. S/ 450.00)',
                  hintText: '450.00',
                  prefixIcon: Icon(Icons.attach_money_rounded),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el precio del producto';
                  }
                  final cleanValue = value
                      .replaceAll('S/', '')
                      .replaceAll('S/.', '')
                      .replaceAll(',', '')
                      .trim();
                  final parsed = double.tryParse(cleanValue);
                  if (parsed == null || parsed <= 0) {
                    return 'Ingrese un precio numérico válido mayor a 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Campo 4: Descripción Técnica
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción Técnica',
                  hintText: 'Ingrese especificaciones, modelo, compatibilidad...',
                  prefixIcon: Icon(Icons.description_outlined),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese la descripción técnica';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Botón de Acción Destacada: Guardar Componente
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.graphite,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Guardar Componente',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
