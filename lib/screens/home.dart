import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

   userModel usermodel = userModel();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance.collection('Registration').doc(usermodel.uid).get().then((value) => this.usermodel=userModel.fromMap(value.data()));
    setState(() {
      
    });
  }

  @override

  
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Welcome" ), centerTitle: true,),

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
  Text("${usermodel.firstName} ${usermodel.secondName}"),
  Text("${usermodel.email}"),

  addHorizontalSpace(20),
ActionChip(label: Text("Logout"), onPressed: (){

logout(context);

})




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
}