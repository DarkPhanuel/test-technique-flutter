import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_technique_flutter/pages/cart_page.dart';
import 'package:test_technique_flutter/pages/detail_page.dart';
import 'package:test_technique_flutter/pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/cart': (_) => CartPage(),
        '/detailPage': (_) => DetailPage(),
      },
    );
  }
}
