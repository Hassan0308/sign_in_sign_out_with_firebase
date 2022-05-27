import 'dart:io';

import 'package:flutter/material.dart';

//image picker for picking the image from device
import 'package:image_picker/image_picker.dart';
//firebase storage for storing the image to the firebase storage
import 'package:firebase_storage/firebase_storage.dart';
//and clound firebase for saving the url for uploaded images to our application
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_in_sign_out_with_firebase/utils/vertical_horizontal_space.dart';



class ImageUpload extends StatefulWidget {

  //we need the user id to create a image folder for particular user

  String? userId;
  ImageUpload({Key? key, this.userId}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {

  //some initializing code
File? _image;
final imagePicker = ImagePicker();
String? downloadUrl;


//Image Picker Methods
Future ImagePickerMethd ()async{

  //picking the file
  final pick = await imagePicker.pickImage(source: ImageSource.gallery);
  setState(() {
    if(pick!=null){

      _image=File(pick.path);
    }
    else{
//showing snack bar
showSnackBar("No file selected", Duration(milliseconds: 400));

    }
  });
}

//snackbar method for showing errors
showSnackBar(String snacktext, Duration d){
  
  final snackbar=SnackBar(content: Text(snacktext), duration: d,);
  ScaffoldMessenger.of(context).showSnackBar(snackbar);

}

//uploading an image then getting the download url and then
//adding that download url to our cloudfirestore

Future uploadImage()async{
  final postid=DateTime.now().millisecondsSinceEpoch.toString();
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

Reference ref = FirebaseStorage.instance.ref().child("${widget.userId}/images").child("post_id$postid");
await ref.putFile(_image!);
downloadUrl= await ref.getDownloadURL();
// uploading URL to firebase
firebaseFirestore.collection("Registration").doc(widget.userId).collection("images").add({'downloadURL' :  downloadUrl}).whenComplete(() => showSnackBar("Image Uploaded Sucessfullt", Duration(milliseconds: 500)));


}



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
appBar: AppBar(title: Text("Upload Image")),

body: Center(child: Padding(padding: EdgeInsets.all(8),

//for rounded rectangle clip
child:ClipRRect(
borderRadius: BorderRadius.circular(30),
child: SizedBox(
height: 500,
width: double.infinity,
child: Column(

  children: [
    Text("Upload Image"),
    addVerticalSpace(10),
    Expanded(child: Container(width: 350, decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.red),

    ),
    child: Center(child: Column(

      children: [

        Expanded(
          
          child: _image==null? Center(child: Text("No image selected!"),):
        
        Image.file(_image!),),
ElevatedButton(onPressed: (){

ImagePickerMethd();

}, child: Text("Select Image")),
ElevatedButton(onPressed: (){

if(_image!=null){


uploadImage();}
else{

  showSnackBar("No Image Selected!", Duration(milliseconds: 500));
}

}, child: Text("Upload Image")),

      ],
    )),
    
    ))



  ],
),

),

) ,

)),


    );
  }


}