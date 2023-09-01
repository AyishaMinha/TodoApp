import 'package:flutter/material.dart';
import 'package:todoapp/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

changeScreen(){
  Future.delayed(Duration(seconds: 5),() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  },
  );
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fimages%2Fanimals%2Fcat&psig=AOvVaw22w3NucyV2KsZOUztPQrPt&ust=1693629686148000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCKCQmrDMiIEDFQAAAAAdAAAAABAE',height: 30,width: 30,),
          Text('Baabtra'),
          ],
        ),
      ),
    );
  }
}