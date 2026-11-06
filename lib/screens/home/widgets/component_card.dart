import 'package:flutter/material.dart';
import '../../../models/hardware_component.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

/// Tarjeta técnica de hardware para el Catálogo SENATI.
class ComponentCard extends StatelessWidget {
  final HardwareComponent component;
  final VoidCallback onTap;

  const ComponentCard({
    super.key,
    required this.component,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final badgeColor = component.categoryBadgeColor;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D0F172A),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: AppColors.emeraldLight.withValues(alpha: 0.6),
          highlightColor: AppColors.borderLight,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Franja lateral de color por categoría
                Container(
                  width: 5,
                  color: badgeColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        // Icono técnico con gradiente oscuro y acento esmeralda
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.graphite, AppColors.graphiteHover],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x180F172A),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            component.categoryIcon,
                            color: AppColors.emeraldAccent,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Información central del equipo
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      component.name,
                                      style: const TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.textPrimary,
                                        letterSpacing: -0.3,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 1.5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF1F5F9),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      component.id,
                                      style: const TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: badgeColor.withValues(alpha: 0.10),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: badgeColor.withValues(alpha: 0.28),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: Text(
                                      component.category,
                                      style: TextStyle(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w700,
                                        color: badgeColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      '• ${component.stockCount} en stock',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textSecondary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Precio + Botón de ficha
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.emeraldLight,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: AppColors.emeraldBorder,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            Formatters.formatCurrency(component.price),
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.emeraldDark,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColors.graphite,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                            color: AppColors.emeraldAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
