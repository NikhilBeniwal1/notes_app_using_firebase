import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/model/note_model.dart';
import 'package:notes_app_firebase/onboarding/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.userID});
String userID;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseFirestore firestore;
TextEditingController  _titleEditingController = TextEditingController();
var  _descEditingController = TextEditingController();
@override
  void initState() {
        super.initState();
        firestore = FirebaseFirestore.instance;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes app using firebase"),
      actions: [IconButton(onPressed: (){}, icon: Icon(Icons.search))],
      centerTitle: true,
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            /// list of notes  // future builder
            FutureBuilder<QuerySnapshot<Map<String,dynamic>>>(future: firestore.collection('users').doc(widget.userID).collection("notes").orderBy("time",descending: true).get() ,
                builder: (context, snapShot) {
              if(snapShot.connectionState == ConnectionState.waiting){ return Center(child: CircularProgressIndicator());}
              else if(snapShot.hasError){return Center(child: Text("unable to fetch notes : "));}
              else if(snapShot.hasData) {return Expanded(
                child: snapShot.data!.docs.isNotEmpty ? ListView.builder (
                  itemCount: snapShot.data!.docs.length,
                  itemBuilder: (context, index) {
                    NoteModel currNote = NoteModel.fromMap(snapShot.data!.docs[index].data());

                    return ListTile(
                      onTap: (){},
                      title: Text("${currNote.title}"),
                      subtitle: Text("${currNote.desc}"),
                      trailing:  Container(
                        width: 80,
                        child: Row(
                          children: [ IconButton(onPressed: (){

                            /// Update Notes from here


                            showModalBottomSheet(backgroundColor: Colors.yellow.shade100,isDismissible: false,context: context, builder: (context) {

                              _titleEditingController.text = NoteModel.fromMap(snapShot.data!.docs[index].data()).title;
                              _descEditingController.text = NoteModel.fromMap(snapShot.data!.docs[index].data()).desc;
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    SizedBox(height: 30.0),
                                    Text("Update note",style: TextStyle(color: Colors.green,fontSize: 30),),

                                    SizedBox(height: 20.0),
                                    /// title
                                    TextField(
                                      controller: _titleEditingController,
                                      decoration: InputDecoration(
                                        labelText: 'Enter note title',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 16.0),

                                    ///desc
                                    TextField(
                                      controller: _descEditingController,
                                      decoration: InputDecoration(
                                        labelText: 'Enter note desc.',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 16.0),


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(onPressed: ()  {
                                         if(_titleEditingController.text.isNotEmpty && _descEditingController.text.isNotEmpty) {
                                                                    firestore
                                                                        .collection(
                                                                            "users")
                                                                        .doc(widget
                                                                            .userID)
                                                                        .collection(
                                                                            "notes")
                                                                        .doc(snapShot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .id)
                                                                        .update(NoteModel(title: _titleEditingController.text, desc: _descEditingController.text,  time: "${DateTime.now().microsecondsSinceEpoch}",)
                                                                            .toMap())
                                                                        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            content: Text(
                                                                                "Note Updated"))))
                                                                        .catchError(
                                                                            (e) {
                                                                      return "Note not Updated";
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                    setState(
                                                                        () {
                                                                      _titleEditingController
                                                                          .clear();
                                                                      _descEditingController
                                                                          .clear();
                                                                    });
                                                                  } else {
                                         ScaffoldMessenger.of(context).showSnackBar(
                                             SnackBar(
                                                 backgroundColor: Colors.yellow,
                                                 behavior: SnackBarBehavior.floating,
                                                 margin: EdgeInsets.only(bottom: 500),
                                                 content: Text("  Enter valid input or clik on cancle",style: TextStyle(color: Colors.black),)));
                                         }
                                                                },
                                            child: Text("    Save    ",style: TextStyle(color: Colors.green),)
                                        ),

                                        ElevatedButton(onPressed: (){
                                          _descEditingController.clear();
                                          _titleEditingController.clear();
                                         Navigator.pop(context);
                                        }, child: Text("Cancle",style: TextStyle(color: Colors.red),))
                                      ],
                                    ),



                                  ],),
                                );
                              },);




                          }, icon: Icon(Icons.edit)),
                          IconButton(onPressed: (){
                            showDialog(context: context, builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("you are about to delete a note"),
                                // content: ,
                                actions: [

                                    ElevatedButton(
                                        style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.red)),

                                        onPressed: (){
                                      /// delete notes from here
                                      firestore.collection("users").doc(widget.userID)
                                          .collection("notes").doc(snapShot.data!.docs[index].id).delete()
                                          .then((value) => Text("Note Deleted")).catchError((e) {
                                        return "note not updated";
                                      } );
Navigator.pop(context);
                                      setState(() {

                                      });

                                    }, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Delete "),Icon(Icons.delete)],) ),
                                  SizedBox(height: 30,),
                                  ElevatedButton(
                                    style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.green),backgroundColor: MaterialStateProperty.all(Colors.grey.shade300)),
                                      
                                      onPressed: (){Navigator.pop(context);}, child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("cancel "),Icon(Icons.cancel)],) ),


                                ],
                              );
                            },);

                          }, icon: Icon(Icons.delete,color: Colors.red.shade400,)) ],),
                      ),
                    );
                  },) : Center(child: Text("No Notes Yet!")),
              );}
              else{return Container();}

                }
              ),


          ],
        ),
      ),
floatingActionButton: FloatingActionButton(onPressed: (){
  showModelBottomSheet ();
},
child: Icon(Icons.add),
),
backgroundColor: Colors.green.shade100,

      drawer: drawer(),

    );
  }

  Future<Widget?> showModelBottomSheet (){
  return showModalBottomSheet(backgroundColor: Colors.yellow.shade100,isDismissible: false ,context: context, builder: (context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        SizedBox(height: 30.0),
Text("Add New Notes.",style: TextStyle(color: Colors.green,fontSize: 30),),

        SizedBox(height: 20.0),
        /// title
        TextField(
          controller: _titleEditingController,
          decoration: InputDecoration(
            labelText: 'Enter note title',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),

        ///desc
        TextField(
          controller: _descEditingController,
          decoration: InputDecoration(
            labelText: 'Enter note desc.',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),


        Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: ()  {

                  if(_titleEditingController.text.isNotEmpty && _descEditingController.text.isNotEmpty)  {
                          var collRef = firestore.collection("users");
                          collRef
                              .doc(widget.userID)
                              .collection("notes")
                              .add(NoteModel(
                                          title: _titleEditingController.text,
                                          desc: _descEditingController.text,
                          time: "${DateTime.now().microsecondsSinceEpoch}",
                          )
                                      .toMap()
                                  )
                              .then((value) => "Note added : $value")
                              .catchError((e) {
                            return "Note not added";
                          });
                          setState(() {
                            _titleEditingController.clear();
                            _descEditingController.clear();
                            Navigator.pop(context);
                          });
                        } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.yellow,content: Text("   pls enter valid input or click on cancle",style: TextStyle(color: Colors.black),),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 500),),);
                  }
                      },
                child: Text("    Save    ",style: TextStyle(color: Colors.green),)
            ),

            ElevatedButton(onPressed: (){
              _descEditingController.clear();
              _titleEditingController.clear();
              Navigator.pop(context);
            }, child: Text("Cancle",style: TextStyle(color: Colors.red),))

          ],
        ),


      ],),
    );
  },);
  }
  Widget drawer(){
  return Drawer(elevation: 5, child: Column(

    children: [
    InkWell(
      onTap: () async {
        var pref = await SharedPreferences.getInstance();
        pref.setBool(LoginPage.LOGIN_PREF_KEY, false);
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),));

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          SizedBox(height: 50,),
          Text("Log out"),Icon(Icons.logout)
        ],),
      ),
    )
  ],),);
  }

}
// stream builder
/*StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(stream: firestore.collection('notes').snapshots() ,
builder: (context, snapShot) {
if(snapShot.connectionState == ConnectionState.waiting){ return Center(child: CircularProgressIndicator());}
else if(snapShot.hasError){return Center(child: Text("unable to fetch notes : "));}
else if(snapShot.hasData) {return Expanded(
child: ListView.builder(
itemCount: snapShot.data!.docs.length,
itemBuilder: (context, index) {
NoteModel currNote = NoteModel.fromMap(snapShot.data!.docs[index].data());

return ListTile(
onTap: (){},
title: Text("${NoteModel.fromMap(snapShot.data!.docs[index].data()).title}"),
subtitle: Text("${currNote.desc}"),
);
},),
);}
else{return Container();}

}
),*/
