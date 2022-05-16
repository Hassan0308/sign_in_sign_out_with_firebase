import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_sign_out_with_firebase/screens/home.dart';
import 'package:sign_in_sign_out_with_firebase/screens/register.dart';
import 'package:sign_in_sign_out_with_firebase/utils/vertical_horizontal_space.dart';


class Login_screen extends StatefulWidget {
  const Login_screen({ Key? key }) : super(key: key);

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {

//form key for authentication
  final formkey=GlobalKey<FormState>();
  //editing controller
  final TextEditingController emailController= new TextEditingController();
  final TextEditingController passwordController= new TextEditingController();

  //firebase 
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

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

//password field

final passwordField=TextFormField(

autofocus: false,
obscureText: true,
controller: passwordController,

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
  passwordController.text= value!;

},

decoration: InputDecoration(
prefixIcon: Icon(Icons.lock),
contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
hintText: "Password",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10)

),


),

textInputAction: TextInputAction.done,
    );


    //login button

    final login_button= Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
child: MaterialButton(
  
  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),

  minWidth: MediaQuery.of(context).size.width,
  
  onPressed:() {
  
  login(emailController.text, passwordController.text);
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
backgroundColor: Colors.white,
body: Center(child: SingleChildScrollView
(child: Padding(
  padding: EdgeInsets.all(36.0),
  child:   Container
  
  
  
  (child: Form
  
  (
  
    
  
    key: formkey,
  
    child: Column
  
  (
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    
    children: <Widget>[
  
  SizedBox(

    height: 200,
    child: Image.asset("assets/logo.png"),

  ),
  
    emailField,
  
    addVerticalSpace(10),
  
    
  
    passwordField,
  
     addVerticalSpace(10),
  
    login_button,
      
     addVerticalSpace(10),
     Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text("Don't have any account? "),
//gesture detector
GestureDetector(
onTap: () {
  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
},
child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),),

)

],


     ),
  
  
  
  
  
  ],)),),
),)),

    );
  }
//login function

void login(String email , String pass) async{


//in order to validate form key
  if(formkey.currentState!.validate()){

await _auth.signInWithEmailAndPassword(email: email, password: pass).then((uid) => {

Fluttertoast.showToast(msg: "Login Successfull"),
Navigator.of(context).pushReplacement(MaterialPageRoute(builder:  (context) => Home(),))

}).catchError((e){
  Fluttertoast.showToast(msg: e!.message);
  
});
    
  }
}

}


