import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/app/app.dart';
import 'package:todoapp/bootstrap.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bootstrap(() => const App());
}
