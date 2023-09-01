
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImageTaskRepo {
  Future<void> createImageTask(String task, String description, String duration, List <XFile> images, BuildContext context) async {

    final uuid = Uuid();
    final taskid = uuid.v4();
    List <String> taskImages =  [];
    final _auth = FirebaseAuth.instance;
    final CollectionReference imageTaskRef = FirebaseFirestore.instance.collection('imagetaskcollection');

    try {
      for(final element in images){
        final reference = FirebaseStorage.instance.ref().child('image task').child(element.name);
        final file = File(element.path);
        await reference.putFile(file);
        final imageUrl = await reference.getDownloadURL();
        taskImages.add(imageUrl);


      }

      await imageTaskRef.doc(taskid).set(
        {
          'ueserid' : _auth.currentUser!.uid,
          'taskid' : taskid,
          'task' : task,
          'description' : description,
          'duration' : duration,
          'taskimage' : taskImages,
        }
      );
    }on FirebaseAuthException catch (e) {
      throw Exception('failed!');
    }
  }
}