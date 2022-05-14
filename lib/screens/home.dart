import 'package:flutter/material.dart';
import 'package:sign_in_sign_out_with_firebase/screens/login.dart';
import 'package:sign_in_sign_out_with_firebase/screens/register.dart';
import 'package:sign_in_sign_out_with_firebase/utils/vertical_horizontal_space.dart';


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  Text("Muhammad Hassan Kareem"),
  Text("Programmingwithhassan@gmail.com"),

  addHorizontalSpace(20),
ActionChip(label: Text("Logout"), onPressed: (){})




            ],
          ),
        ) ),
    );
  }
}