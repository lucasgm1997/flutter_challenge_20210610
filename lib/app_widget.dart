import 'package:flutter/material.dart';
import 'package:flutterchallange/src/home/bloc/home_module.dart';
import 'package:flutterchallange/src/home/home_page.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...homeModule
      ],
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/': (_) => const HomePage(),
        },
      ),
    );
  }
}