import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_sign_out_with_firebase/imageUpload/imageUpload.dart';
import 'package:sign_in_sign_out_with_firebase/imageUpload/showImage.dart';
import 'package:sign_in_sign_out_with_firebase/screens/login.dart';
import 'package:sign_in_sign_out_with_firebase/screens/register.dart';
import 'package:sign_in_sign_out_with_firebase/utils/vertical_horizontal_space.dart';

import '../models/user-model.dart';


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   //firbase auth

  User? user = FirebaseAuth.instance.currentUser;
    //calling our user model

   userModel loginUser = userModel();

 @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Registration")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loginUser = userModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override

  
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appBar(),

      body: Center(
        
        child:SingleChildScrollView(

          child: Column(

            children: [
                SizedBox(

    height: 200,
    child: Image.asset("assets/logo.png" , fit: BoxFit.contain,),
    

  ),

  Text("WELCOME BACK", style: TextStyle(

    fontSize: 20,
    fontWeight: FontWeight.bold

  ),),
  addVerticalSpace(10),
  Text("${loginUser.firstName} ${loginUser.secondName}"),
   addVerticalSpace(10),
  Text("${loginUser.email}"),
   addVerticalSpace(10),
    Text("${loginUser.uid}"),
     addVerticalSpace(10),

 

  ElevatedButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: ((context) =>  ImageUpload(userId: loginUser.uid))));


  }, child: Text("Upload an image")),
  ElevatedButton(onPressed: (){

Navigator.push(context, MaterialPageRoute(builder: ((context) => showUpload(userid: loginUser.uid))));


  }, child: Text("Show")),





// ActionChip(label: Text("Logout"), onPressed: (){

// logout(context);

// })




            ],
          ),
        ) ),
    );
  }


//function to loutout

  Future<void> logout(BuildContext context)async{

    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Login_screen()));
  }


  //custom AppBar
  _appBar(){
//getting the size of appBar
// we will get the height

final appBarHeight = AppBar().preferredSize.height;
return PreferredSize(

preferredSize: Size.fromHeight(appBarHeight) ,
child: AppBar(title: const Text("Profile"),
actions: [
  IconButton(onPressed: (){

logout(context);

  }, icon: Icon(Icons.logout)),
  

  
],


),


);

  }
}