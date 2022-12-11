import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import from dev
import 'providers/providers.dart';
import 'screens/screens.dart';
import 'package:app_movie/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
      ],
      child: MaterialApp(
        title: 'App movie',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'details': (_) => const DetailsScreen(),
        },
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
