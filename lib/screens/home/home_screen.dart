import 'package:flutter/material.dart';
import '../../models/hardware_component.dart';
import '../../routes/app_routes.dart';
import '../../state/catalog_controller.dart';
import '../../theme/app_theme.dart';
import '../../utils/formatters.dart';
import '../form/register_modal.dart';
import 'widgets/category_chips.dart';
import 'widgets/component_card.dart';

/// Pantalla Principal (Catálogo / Home) en la ruta /#/home.
class HomeScreen extends StatefulWidget {
  final CatalogController controller;

  const HomeScreen({
    super.key,
    required this.controller,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchFieldController = TextEditingController();

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  void _openRegisterModal() {
    RegisterComponentModal.show(
      context,
      onSave: (newComponent) {
        widget.controller.addComponent(newComponent);
      },
    );
  }

  void _navigateToDetail(HardwareComponent component) {
    Navigator.pushNamed(
      context,
      AppRoutes.details,
      arguments: component,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final components = widget.controller.filteredComponents;
        final allComponents = widget.controller.allComponents;
        final isSearching = widget.controller.isSearchActive;

        final totalValue = allComponents.fold<double>(
          0,
          (sum, item) => sum + item.price,
        );

        return Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(3),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(height: 3, color: AppColors.emeraldAccent),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(height: 3, color: const Color(0xFF2563EB)),
                  ),
                ],
              ),
            ),
            title: isSearching
                ? TextField(
                    controller: _searchFieldController,
                    autofocus: true,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    cursorColor: AppColors.emeraldAccent,
                    decoration: InputDecoration(
                      hintText: 'Buscar por nombre, categoría o especificación...',
                      hintStyle: const TextStyle(color: Colors.white60),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear_rounded, color: Colors.white70),
                        onPressed: () {
                          _searchFieldController.clear();
                          widget.controller.setSearchQuery('');
                        },
                      ),
                    ),
                    onChanged: (val) => widget.controller.setSearchQuery(val),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.emeraldPrimary.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.emeraldAccent.withValues(alpha: 0.35),
                          ),
                        ),
                        child: const Icon(
                          Icons.developer_board_rounded,
                          color: AppColors.emeraldAccent,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('Catálogo SENATI'),
                    ],
                  ),
            actions: [
              IconButton(
                icon: Icon(
                  isSearching ? Icons.close_rounded : Icons.search_rounded,
                  color: Colors.white,
                ),
                tooltip: isSearching ? 'Cerrar búsqueda' : 'Buscar componente',
                onPressed: () {
                  if (isSearching) {
                    _searchFieldController.clear();
                  }
                  widget.controller.toggleSearch();
                },
              ),
              if (!isSearching)
                IconButton(
                  icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 20),
                  tooltip: 'Cerrar sesión',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                ),
              const SizedBox(width: 8),
            ],
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1020),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Panel de resumen tipo consola ejecutiva
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.graphite, Color(0xFF1E293B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x180F172A),
                          blurRadius: 14,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'INVENTARIO TÉCNICO DE LABORATORIO',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.emeraldAccent,
                                  letterSpacing: 0.7,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Seleccione una categoría o toque un equipo para ver su ficha:',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFCBD5E1),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        _MetricBadge(
                          label: 'Equipos',
                          value: '${components.length}',
                          accentColor: AppColors.emeraldAccent,
                        ),
                        const SizedBox(width: 6),
                        _MetricBadge(
                          label: 'Total',
                          value: Formatters.formatCurrency(totalValue),
                          accentColor: const Color(0xFFFBBF24),
                        ),
                      ],
                    ),
                  ),

                  // Barra horizontal de chips de filtrado
                  CategoryChipsBar(
                    selectedCategory: widget.controller.selectedCategory,
                    onCategorySelected: (cat) {
                      widget.controller.setCategory(cat);
                    },
                  ),

                  const SizedBox(height: 8),

                  // Lista o Grilla responsiva de componentes
                  Expanded(
                    child: components.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: AppColors.border),
                                    ),
                                    child: const Icon(
                                      Icons.search_off_rounded,
                                      size: 32,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'No se encontraron componentes en esta categoría.',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              final isWide = constraints.maxWidth >= 860;
                              if (isWide) {
                                return GridView.builder(
                                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 92),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 82,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: components.length,
                                  itemBuilder: (context, index) {
                                    final item = components[index];
                                    return ComponentCard(
                                      component: item,
                                      onTap: () => _navigateToDetail(item),
                                    );
                                  },
                                );
                              }

                              return ListView.separated(
                                padding: const EdgeInsets.fromLTRB(16, 4, 16, 92),
                                itemCount: components.length,
                                separatorBuilder: (_, _) => const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final item = components[index];
                                  return ComponentCard(
                                    component: item,
                                    onTap: () => _navigateToDetail(item),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _openRegisterModal,
            backgroundColor: AppColors.graphite,
            foregroundColor: Colors.white,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: AppColors.emeraldAccent.withValues(alpha: 0.45),
                width: 1.2,
              ),
            ),
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.emeraldPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
            ),
            label: const Text(
              'Nuevo Componente',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13.5,
                letterSpacing: -0.2,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MetricBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color accentColor;

  const _MetricBadge({
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: accentColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11.5,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
