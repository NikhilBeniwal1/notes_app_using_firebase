

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app_firebase/custom_widgets/custom_elevatedbutton.dart';
import 'package:notes_app_firebase/custom_widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  String profilePicUrl;
  ProfileScreen({required this.profilePicUrl});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CroppedFile? croppedImage ;
  late FirebaseFirestore firestore;

  String? userID;
  String? userName;
  String? mobileNo;
  String? emailId;


  @override
  void initState() {
    // TODO: implement initState
   firestore =  FirebaseFirestore.instance;

 _getUserId();

  }


  Future<void> _getUserId()async{
    var pref = await SharedPreferences.getInstance();
    userID =  pref.getString("userId");
    var userData = await firestore
        .collection('users')
        .doc(userID).get();
    userName = userData.data()!["name"];
    mobileNo = userData.data()!["mobile"];
        emailId = userData.data()!["emial"];

setState(() {

});
  }

 // const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 20,),
          croppedImage != null ? ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image.file(
              File(croppedImage!.path),
              height: 140,
              width: 140,
              fit: BoxFit.fill,

            ),
          ) : widget.profilePicUrl != "" ? ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image.network(widget.profilePicUrl
             , height: 140,
              width: 140,
              fit: BoxFit.fill,

            ),
          ) : Icon(Icons.account_circle_rounded,size: 160,),

          /// pick image
          ElevatedButton(onPressed: () async {

    openImagePicker();

          }, child: Text("select Image")),
SizedBox(height: 10,),
          /// upload image or select and image to upload first
        croppedImage != null ?  ElevatedButton(onPressed: (){

            uploadImage();

          }, child: Text("Upload Image")) : Text("Select and Image to upload"),


          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            height: 250,
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Profile details")],
                    ),
                    ListTile(
                      leading: Icon(Icons.account_box),
                      title: Text("Name"),
                      trailing: CustomText(string: "$userName",fontSize: 16,),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text("EMail Id"),
                      trailing: CustomText(string: "$emailId",fontSize: 16,),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text("Mobile No"),
                      trailing: CustomText(string: "$mobileNo",fontSize: 16,),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(
            height: 30,
          ),


        //  CustomElevatedButton(onPressed: (){}, buttonText: "Save changes",textcolor: Colors.white,width: 300,height: 30,),


        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    floatingActionButton: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.double_arrow_sharp), label: Text("Save Changes"))
    );

  }

  void openImagePicker() async {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedImage!=null){
     croppedImage = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
         CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],

      );

setState(() {

});
    }
  }

  void uploadImage()async{

    var prefs = await SharedPreferences.getInstance();

    var userId = prefs.getString("userId",);

    var currTimeInMillis = DateTime.now().microsecondsSinceEpoch;
    var storage = FirebaseStorage.instance;
    var storageRef = storage.ref().child("images/profilepics/IMG_$currTimeInMillis.jpg");
try {
storageRef.putFile(File(croppedImage!.path)).then((value) async {
  /// creating img url
  var imgUrl = await value.ref.getDownloadURL();
  /// when uploding is completed
  var firestore = FirebaseFirestore.instance;
  /// current profile pic updating here
 firestore.collection("users").doc(userId).update({"profilepics":imgUrl});

  /// adding profile pic url in users collection

  firestore.collection("users").doc(userId).collection("profilepics").add(
      {
        "imgUrl": imgUrl,
        "uploadedAt": currTimeInMillis
      });

});


} on FirebaseException catch (e) {
  print("Eror while uploading ${e} ");
}


  }
}
