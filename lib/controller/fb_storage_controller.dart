import 'dart:async';
import 'dart:io';
import 'package:caregiver_app/model/fb_response.dart';
import 'package:firebase_storage/firebase_storage.dart';


import '../firebase_helper.dart';



class FbStorageController with FirebaseHelper {
  final FirebaseStorage _storage = FirebaseStorage.instance;


  Future<UploadTask> upload(String path, String id, String name, String consanguinity) {
    Completer<UploadTask> completer = Completer<UploadTask>();
    UploadTask uploadTask = FirebaseStorage.instance
        .ref('images/$id.$name.$consanguinity')
        .putFile(File(path));

    uploadTask.whenComplete(() {
      if (!completer.isCompleted) {
        completer.complete(uploadTask);
      }
    });

    return completer.future;
  }



  Future<List<Reference>> read({required String id}) async {
    ListResult listResult = await _storage.ref('images').list();
    List<Reference> filteredItems = [];
    for (Reference ref in listResult.items) {
      if (ref.name.contains(id)) {
        filteredItems.add(ref);
      }
    }
    if (filteredItems.isNotEmpty) {
      return filteredItems;
    }else{
      return [];
    }

  }




}
