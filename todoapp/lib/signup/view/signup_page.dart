import 'package:flutter/material.dart';
import 'package:todoapp/login/login.dart';
import 'package:todoapp/signup/repository/signupRepo.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 189, 182, 250),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 146, 135, 244),
        title: Text("Signup here!!!",
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
              controller: _nameController,
              validator: (value) {
                if(value!.isEmpty){
                  return 'Please fill this field!';
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                hintText: 'Name'),            
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _placeController,
              validator: (value) {
                if(value!.isEmpty){
                  return 'Please fill this field';
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                hintText: 'Place'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _phoneController,
              validator: (value) {
                if(value!.isEmpty){
                  return 'Please enter your Phone number!';
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                hintText: 'Phone'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if(value!.isEmpty){
                  return 'Please enter your Email-Id!';
                }
              },
             decoration: InputDecoration(
              border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
              hintText: 'Email_Id'),
            ),
            SizedBox(
              height: 10,
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
            
            ElevatedButton(onPressed: () async{
              if(_formKey.currentState!.validate())
              {
                await SignupRepo().createUser(
                  _nameController.text,
                  _placeController.text,
                   _phoneController.text,
                   _emailController.text,
                   _passwordController.text,

                   context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

              }
            
            }, 
            style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 146, 135, 244),
                ),
            child: Text('SignUp',
            style: 
            TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            )
            ),
          ],
        ),
      ),
    );
  }
}
