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
            FutureBuilder<QuerySnapshot<Map<String,dynamic>>>(future: firestore.collection('users').doc(widget.userID).collection("notes").get() ,
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
                      trailing:  Container(
                        width: 80,
                        child: Row(
                          children: [ IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red.shade400,)) ],),
                      ),
                    );
                  },),
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
  return showModalBottomSheet(context: context, builder: (context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        SizedBox(height: 30.0),
Text("Add New Notes",style: TextStyle(color: Colors.green,fontSize: 30),),

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


        ElevatedButton(onPressed: (){
          var collRef = firestore.collection("users");
          collRef.doc(widget.userID).collection("notes").add(NoteModel(title: _titleEditingController.text , desc: _descEditingController.text).toMap()
            /*{"title": "this is notes title",
        "desc":"this is notes des" }*/)
              .then((value) => "Note added : $value")
              .catchError((e){
            return "Note not added";
          }); setState(() {
            _titleEditingController.clear();
            _descEditingController.clear();
            Navigator.pop(context);
          });
        },
            child: Text("    Save    ")
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
