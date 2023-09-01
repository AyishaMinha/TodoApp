import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/home/home.dart';

import 'package:todoapp/signup/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



  



class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  @override
  

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 189, 182, 250),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 146, 135, 244),
        title: Text("Login here!!",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
        
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _usernameController,
              validator: (value) {
                if(value!.isEmpty){
                  return 'Please fill this field!';
                }
              },


              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    
                  borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Username'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if(value!.isEmpty){
                  return 'Please fill this field!';
                }
              },

              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Password'),
            ),
            SizedBox(
                  height: 10,
                ),
            ElevatedButton(
                onPressed: () async {
                  try {
                  final _auth  = FirebaseAuth.instance;
                  final userRef = await _auth.signInWithEmailAndPassword(email: _usernameController.text, password: _passwordController.text);
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      )); 
                  
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid username or password')));
                    
                  }
                  
                },
                style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 146, 135, 244),
                ),
                child: Text(
                  'Login',
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                )),
                SizedBox(
                  height: 10,
                ),
            Text('Not yet registered!!'),
            SizedBox(
                  height: 10,
                ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 146, 135, 244),
                ),
                child: Text(
                  'SignUp',
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                )),
          ],
        ),
      ),
    );
  }
}
