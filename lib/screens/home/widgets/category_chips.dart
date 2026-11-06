import 'package:flutter/material.dart';
import '../../../data/mock_components.dart';
import '../../../theme/app_theme.dart';

/// Barra de filtrado horizontal por categorías con iconos técnicos y estilo consola.
class CategoryChipsBar extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryChipsBar({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'todos':
        return Icons.grid_view_rounded;
      case 'hardware':
        return Icons.developer_board_rounded;
      case 'procesadores':
        return Icons.memory_rounded;
      case 'almacenamiento':
        return Icons.storage_rounded;
      case 'periféricos':
      case 'perifericos':
        return Icons.keyboard_rounded;
      default:
        return Icons.devices_other_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: CatalogCategories.filterList.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = CatalogCategories.filterList[index];
          final isSelected = category.toLowerCase() == selectedCategory.toLowerCase();

          return Container(
            decoration: isSelected
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x240F172A),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  )
                : null,
            child: ChoiceChip(
              avatar: Icon(
                _iconForCategory(category),
                size: 16,
                color: isSelected ? AppColors.emeraldAccent : AppColors.textSecondary,
              ),
              label: Text(category),
              selected: isSelected,
              showCheckmark: false,
              onSelected: (_) => onCategorySelected(category),
              labelStyle: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.textSecondary,
                letterSpacing: -0.2,
              ),
              backgroundColor: AppColors.surface,
              selectedColor: AppColors.graphite,
              side: BorderSide(
                color: isSelected ? AppColors.graphite : AppColors.border,
                width: 1.2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          );
        },
      ),
    );
  }
}
