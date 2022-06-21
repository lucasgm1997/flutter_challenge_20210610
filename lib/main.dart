import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterchallange/app_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().whenComplete(() {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInAnonymously().then((value) {
      runApp(const AppWidget());
    });
  });

}
