import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class showUpload extends StatefulWidget {

  String? userid;

  showUpload({Key? key, this.userid}) : super(key: key);

  @override
  State<showUpload> createState() => _showUploadState();
}

class _showUploadState extends State<showUpload> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
appBar: AppBar(title: Text("Your Images")),
body: StreamBuilder(
  
  
  stream: FirebaseFirestore.instance.collection('Registration').doc(widget.userid).collection('images').snapshots(),

  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

if(!snapshot.hasData){

  return Center(child: Text("No Data Found"),);
}else{

  return ListView.builder(
    
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (
    
    
    BuildContext context , int index)
  {
String url= snapshot.data!.docs[index]['downloadURL'];
return Image.network(
url,
height: 300,
fit: BoxFit.cover,



);
    
  }
  );
  }
}
    
  
  
  
   ),

      );
  }
}