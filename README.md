# Catálogo de Hardware SENATI (SPA Multiplataforma)

Aplicación multiplataforma **Single Page Application (SPA)** desarrollada en **Flutter** y **Dart** para la gestión, filtrado y consulta técnica de componentes de hardware de laboratorio.

## Información Académica
- **Institución:** SENATI — Escuela de Tecnologías de la Información (ETI)
- **Curso:** Aplicaciones para Dispositivos Móviles
- **Instructor:** Jorge Luque Chambi
- **Estudiante:** Rodrigo Daniel Ormeño Llanos (ID: 001681961)
- **Ciclo / Bloque:** IV Ciclo — Bloque 406

## Características Principales
- **Autenticación Institucional (`/#/login`):** Portal de acceso con validación de formularios y carga rápida de credenciales de demostración (`admin@senati.pe` / `123456`).
- **Consola de Inventario Responsiva (`/#/home`):**
  - Panel ejecutivo con métricas en tiempo real (total de equipos, stock global en unidades y valorización total en Soles `S/`).
  - Grilla adaptativa de 2 columnas en pantallas de escritorio/tablet y lista optimizada en dispositivos móviles.
  - Filtrado reactivo por categorías (`Todos`, `Hardware`, `Procesadores`, `Almacenamiento`, `Periféricos`) y búsqueda instantánea.
- **Ficha Técnica Detallada (`/#/details`):** Visualización de código SKU, especificaciones técnicas completas, precio formateado en moneda peruana (`S/`) e indicador de disponibilidad en almacén.
- **Registro Dinámico de Componentes:** Modal inferior (*BottomSheet*) con validaciones para incorporar nuevos equipos al estado reactivo de la aplicación.

## Ejecución del Proyecto

```bash
# Obtener dependencias
flutter pub get

# Ejecutar pruebas unitarias y de widgets
flutter test

# Compilar para producción Web
flutter build web
```
