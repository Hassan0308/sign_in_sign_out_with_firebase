import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_sign_out_with_firebase/models/user-model.dart';
import 'package:sign_in_sign_out_with_firebase/screens/home.dart';
import 'package:sign_in_sign_out_with_firebase/utils/vertical_horizontal_space.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({ Key? key }) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //firbase auth

  final _auth = FirebaseAuth.instance;

  //form auth key
  final formkey = GlobalKey<FormState>();
  //editing controller
  final TextEditingController FnameController= new TextEditingController();
  final TextEditingController LnameController= new TextEditingController();
  final TextEditingController emailController= new TextEditingController();
  final TextEditingController passController= new TextEditingController();
  final TextEditingController confirmPassController= new TextEditingController();




  @override
  Widget build(BuildContext context) {

      //First name form field

     final FnameField=TextFormField(

autofocus: false,
controller: FnameController,
keyboardType: TextInputType.name,
validator: (value){
  RegExp regExp=new RegExp(r'^.{3,}$');
  if(value!.isEmpty){

    return ("Please Enter A First Name");
  }
if(!regExp.hasMatch(value)){
  return ("Please Enter A Valid Name (Min 3 characters)");
}
return null;
},

onSaved: (value){
  FnameController.text= value!;

},
decoration: InputDecoration(
prefixIcon: Icon(Icons.account_circle),
contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
hintText: "First Name",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10)

),


),
textInputAction: TextInputAction.next,
    );


    //Second name field

         final SnameField=TextFormField(

autofocus: false,
controller: LnameController,
keyboardType: TextInputType.name,
validator: (value){
 
  if(value!.isEmpty){

    return ("Please Enter A Second Name");
  }

},


onSaved: (value){
  LnameController.text= value!;

},
decoration: InputDecoration(
prefixIcon: Icon(Icons.account_circle),
contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
hintText: "Second Name",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10)

),


),
textInputAction: TextInputAction.next,
    );

    //email field
         final emailField=TextFormField(

autofocus: false,
controller: emailController,
keyboardType: TextInputType.emailAddress,

validator: (value){
if(value!.isEmpty)
{
  return ("Please Enter Your Email");
}

//reg expresson for email validation

if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){

return ("Please Enter A Valid Email");

}
return null;

},

onSaved: (value){
  emailController.text= value!;

},
decoration: InputDecoration(
prefixIcon: Icon(Icons.mail),
contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
hintText: "Email",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10)

),


),
textInputAction: TextInputAction.next,
    );

    //password

    
    
final passwordField=TextFormField(

autofocus: false,
obscureText: true,
controller: passController,

validator: (value){
  RegExp regExp=new RegExp(r'^.{6,}$');
  if(value!.isEmpty){

    return ("Please Enter A Password");
  }
if(!regExp.hasMatch(value)){
  return ("Please Enter A Valid Password (Min 6 characters)");
}
},

onSaved: (value){
  passController.text= value!;

},

decoration: InputDecoration(
prefixIcon: Icon(Icons.lock),
contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
hintText: "Password",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10)

),


),

textInputAction: TextInputAction.next,
    );

    //confirm password

    final CpasswordField=TextFormField(

autofocus: false,
obscureText: true,
controller: confirmPassController,

validator: (Value){

  if(confirmPassController.text != passController.text){

    return "Password don't match";
  }
  return null;

},

onSaved: (value){
  confirmPassController.text= value!;

},

decoration: InputDecoration(
prefixIcon: Icon(Icons.lock),
contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
hintText: " Confirm Password",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10)

),


),

textInputAction: TextInputAction.done,
    );

//login 
final login_button= Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
child: MaterialButton(
  
  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),

  minWidth: MediaQuery.of(context).size.width,
  
  onPressed:() {

    register(emailController.text, passController.text);
  
},
child: Text("Login" , 
textAlign: TextAlign.center,
style: TextStyle(fontSize: 20,
color: Colors.white,
fontWeight: FontWeight.bold,
),

),
),

    );


    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.red,),
        
        onPressed: (){
Navigator.of(context).pop();
        },
        ),
      ),
      backgroundColor: Colors.white,

body: Center(
  child: SingleChildScrollView(

child: Form(
  
  key: formkey,
  child: Padding(
    padding: EdgeInsets.all(36),
    child: Column(
  
  
    children: [
  
       SizedBox(
  
      height: 200,
      child: Image.asset("assets/logo.png"),
  
    ),
      FnameField,
      addVerticalSpace(10),
      SnameField,
      addVerticalSpace(10),
      emailField,
      addVerticalSpace(10),
      passwordField,
      addVerticalSpace(10),
      CpasswordField,
      addVerticalSpace(10),
      login_button,
    ],
  ),
  )),

  ),
)
    );
  }



void register(String email , String password) async{

  if(formkey.currentState!.validate()){
    

    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {

      postDetailToFirestore(),


    }).catchError((e){

      Fluttertoast.showToast(msg: e!.message);

    })
;}}

 postDetailToFirestore() async{

  //calling our firestore
  //calling our user model
  //sending these values

  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  User? user = _auth.currentUser;

   //calling our user model

   userModel usermodel = userModel();
//writing all the values

usermodel.email=user!.email;
usermodel.uid = user.uid;
usermodel.firstName= FnameController.text;
usermodel.secondName = LnameController.text;

   

await firebaseFirestore.collection('Registration').doc(user.uid).set(usermodel.toMap());
Fluttertoast.showToast(msg: "Account Created Successfully!");

Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const Home() ), (route) => false);

}

  }


