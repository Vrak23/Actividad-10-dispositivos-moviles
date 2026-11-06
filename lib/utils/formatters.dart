/// Utilidades de formateo para la aplicación Catálogo SENATI.
class Formatters {
  /// Formatea un valor numérico a moneda peruana (S/.) con separación de miles y decimales.
  /// Ejemplo: 1250.0 -> "S/ 1,250.00"
  static String formatCurrency(double amount) {
    final parts = amount.toStringAsFixed(2).split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    final regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
    final formattedInteger = integerPart.replaceAllMapped(regExp, (Match m) => ',');

    return 'S/ $formattedInteger.$decimalPart';
  }
}
