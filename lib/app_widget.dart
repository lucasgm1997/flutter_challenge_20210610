import 'package:flutter/material.dart';

import 'package:flutterchallange/src/home/home_page.dart';
import 'package:flutterchallange/src/products/products_module.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...productsModule,
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(244, 0, 246, 86)),


        ),
        routes: <String, WidgetBuilder>{
          '/': (_) => const HomePage(),
        },
      ),
    );
  }
}
