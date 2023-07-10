import 'dart:io';

import 'package:caregiver_app/context_extenssion.dart';
import 'package:caregiver_app/controller/fb_storage_controller.dart';
import 'package:caregiver_app/model/fb_response.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDiaryScreen extends StatefulWidget {
  const AddDiaryScreen({required this.id,Key? key}) : super(key: key);
 final String id;
  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  late TextEditingController nameController;
  late TextEditingController consanguinityController;
  late ImagePicker _imagePicker;
  XFile? _pickedImage;
  double? _progressValue = 0;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    consanguinityController = TextEditingController();
    _imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    nameController.dispose();
    consanguinityController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Diary"),
        centerTitle: true,
        backgroundColor: const Color(0xff096b6c),
        elevation: 0,
      ),
      backgroundColor: const Color(0xff096b6c),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              clipBehavior: Clip.antiAlias,
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
              border: Border.all(color: Colors.white)),
              child: _pickedImage == null
                  ? IconButton(
                onPressed: () => _pickImage(),
                icon: const Icon(Icons.add_a_photo_outlined,color: Colors.white,),
                iconSize:24,
              )
                  : Image.file(File(_pickedImage!.path),fit: BoxFit.cover),
            ),

            const SizedBox(height: 20,),
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              maxLength: 50,
              style: const TextStyle(color: Colors.white),
              autocorrect: true,

              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                counterText: '',
                hintText: 'name',
                hintStyle:  const TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.person,color: Colors.white,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: consanguinityController,
              textCapitalization: TextCapitalization.words,
              maxLength: 50,
              autocorrect: true,

              style: const TextStyle(color: Colors.white),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                counterText: '',
                hintText: 'consanguinity',
                hintStyle:  const TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.account_tree,color: Colors.white,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 50,),
            InkWell(
              onTap: () {
                _performUpload();
              },
              child: Container(
                width: double.infinity,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: const Text(
                  "Create New Task",
                  style: TextStyle(color: Color(0xff096b6c), fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _pickImage() async {
    XFile? imageFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() => _pickedImage = imageFile);
    }
  }
  void _performUpload() {
    if (_checkData()) {
      _upload();
    }
  }

  bool _checkData() {
    if (_pickedImage != null&&nameController.text.isNotEmpty&&consanguinityController.text.isNotEmpty) {
      return true;
    }else{
      context.showSnackBar(message: 'Please complete the required data!', error: true);
      return false;
    }

  }

  void _upload() async{
    _updateProgress();
    try{
      await FbStorageController().upload(_pickedImage!.path,widget.id,nameController.text,consanguinityController.text);
      context.showSnackBar(message: 'Uploaded successfully',);
      Navigator.pop(context);
    }catch(e){
      print(e);
      context.showSnackBar(message: '${e}',);
    }


  }

  void _updateProgress({double? value}) {
    setState(() => _progressValue = value);
  }
}
