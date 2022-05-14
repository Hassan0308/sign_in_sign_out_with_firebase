import 'package:flutter/material.dart';
import 'package:sign_in_sign_out_with_firebase/utils/vertical_horizontal_space.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({ Key? key }) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

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
// validator: (){

// },

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
// validator: (){

// },

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
// validator: (){

// },

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

// validator: (){

// },

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

// validator: (){

// },

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
}