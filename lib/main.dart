import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'screens/auth/login_screen.dart';
import 'screens/detail/detail_screen.dart';
import 'screens/home/home_screen.dart';
import 'state/catalog_controller.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CatalogoSenatiApp());
}

class CatalogoSenatiApp extends StatefulWidget {
  const CatalogoSenatiApp({super.key});

  @override
  State<CatalogoSenatiApp> createState() => _CatalogoSenatiAppState();
}

class _CatalogoSenatiAppState extends State<CatalogoSenatiApp> {
  late final CatalogController _catalogController;

  @override
  void initState() {
    super.initState();
    _catalogController = CatalogController();
  }

  @override
  void dispose() {
    _catalogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo SENATI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.initial,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.home: (context) => HomeScreen(controller: _catalogController),
        AppRoutes.details: (context) => const DetailScreen(),
      },
    );
  }
}
