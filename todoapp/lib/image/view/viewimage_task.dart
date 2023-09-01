import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/image/view/card.dart';

class ViewImageTask extends StatelessWidget {
   ViewImageTask({super.key});
  
  final _auth = FirebaseAuth.instance;
  final _taskRef = FirebaseFirestore.instance.collection('imagetaskcollection');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: 
      
      StreamBuilder(
        stream: _taskRef.where('ueserid', isEqualTo: _auth.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final task = snapshot.data!.docs;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                childAspectRatio: 0.7,
                ),
                itemCount: task.length, 
              itemBuilder: (BuildContext context, int index) {
                return CardWidgets(imageTask: task[index]);

              },
              );
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}