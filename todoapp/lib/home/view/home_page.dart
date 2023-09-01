

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/image/view/image_task.dart';
import 'package:todoapp/login/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}
class _HomepageState extends State<HomePage>{
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  
  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late CollectionReference _todoRef;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoRef =  _firestore.collection('TaskCollection');
  }
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 189, 182, 250),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => ImageTask(),
            ));
          }, 
          icon: Icon(Icons.image_rounded),
          ),
          IconButton(
            onPressed: () async {
              await _auth.signOut().then((value) {
                if (!mounted) return;
                Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => LoginScreen()), 
                  (route) => false
                  );

              });
              
              
            },
             icon: Icon(Icons.logout),
             ),
        ],
        backgroundColor: Color.fromARGB(255, 146, 135, 244),
        title: Text("Welcome to home page",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ),

      body: 
       Form(
        key: _formKey,
        
        child: Column(
          children: [
            TextFormField(
      
               controller: _taskController,
                      validator: (value) {
                  if(value!.isEmpty){
                    return 'Please fill this field!';
                  }
                },
          
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      hintText: 'Task'),
      
            ),
            TextFormField(
               controller: _descriptionController,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please fill this field!';
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  hintText: 'Description'),
            ),
            SizedBox(
              height: 10,
            ),

           TextButton(


            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 146, 135, 244)),
            ),

            onPressed: () async{
              if(_formKey.currentState!.validate()){
                await _todoRef.add ({

               'userid' : _auth.currentUser!.uid,
               'task' : _taskController.text,
               'description' : _descriptionController.text,

            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task added successfully')));
            _taskController.clear();
            _descriptionController.clear();

              }
              
            },
            child: Text('Add Task',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
           ),
           ),

           Expanded(

            child: StreamBuilder<QuerySnapshot>
            (
              stream: _todoRef.where('userid', isEqualTo: _auth.currentUser?.uid).snapshots(),

              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                 final List<DocumentSnapshot> documents = snapshot.data!.docs;
                 return ListView.builder(
                   itemCount: documents.length,
                   itemBuilder: (BuildContext context, int index) {

                  
                    final singleDoc = documents[index];

                     return ListTile(
                      title: Text(singleDoc['task'].toString()),
                      subtitle: Text(singleDoc['description']as String),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                                showDialog(
                                  context:  context, 
                                  builder: (BuildContext context) {
                                    final doc = documents[index];
                                    _taskController.text = doc['task'] as String;
                                    _descriptionController.text = doc['description'] as String;


                                    return AlertDialog(
                                      title: Text('Edit task'),
                   

                                      content: Column(
                                        children: [
                                          TextField(
                                            controller: _taskController,
                                            decoration: InputDecoration(
                                              hintText: 'task'

                                            ),
                                          ),
                                          TextField(
                                            controller: _descriptionController,
                                            decoration: InputDecoration(
                                              hintText: 'description'

                                            ),
                                          ),
                                          Row(
                                            children: [
                                              TextButton(

                                                onPressed: () {
                                                  FirebaseFirestore.instance.collection('TaskCollection').doc(singleDoc.id).update({
                                                    'task' : _taskController.text,
                                                    'description': _descriptionController.text,
                                                  });
                                                  _taskController.clear();
                                                  _descriptionController.clear();
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated Successfully'),));
                                                  Navigator.pop(context);
                                                }, 
                                              child: Text('Save')
                                              ),
                                              TextButton(

                                                onPressed: () {
                                                Navigator.pop(context);  
                                                }, 
                                              child: Text('Cancel')
                                              ),

                                            ],

                                          ),
                                        ],
                                      ),

                                    );
                                    
                                  }
                                  );
                          }, 
                          ),
                           IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              final todo = _todoRef.doc(singleDoc.id);
                              todo.delete();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted Successfully'),));
                          }, 
                          ),
                        ],
                      ),
                     );
                   },
                  
                   
                 );

              }
              ),
            ),

          ],
        ),
      ),

     );

  }
}

      


