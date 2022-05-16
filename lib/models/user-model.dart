class userModel{


//initializing
String? uid;
String? email;
String? firstName;
String? secondName;

//create model
userModel({this.uid , this.email , this.firstName , this.secondName});


//receive data from server

factory userModel.fromMap(map){

return userModel(
uid: map['uid'],
email: map['email'],
firstName: map['firstName'],
secondName: map['secondName'],

);


}
//sending data to our server

Map<String,dynamic> toMap(){
  return{
    'uid':uid,
    'email':email,
    'firstName':firstName,
    'secondName':secondName,


  };
}


}