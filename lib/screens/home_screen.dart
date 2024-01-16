import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/model/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      centerTitle: true,
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            /// list of notes
            FutureBuilder<QuerySnapshot<Map<String,dynamic>>>(future: firestore.collection('notes').get() ,
                builder: (context, snapShot) {
              if(snapShot.connectionState == ConnectionState.waiting){ return Center(child: CircularProgressIndicator());}
              else if(snapShot.hasError){return Center(child: Text("unable to fetch notes : "));}
              else if(snapShot.hasData) {return Expanded(
                child: ListView.builder(
                  itemCount: snapShot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){},
                      title: Text("${snapShot.data!.docs[index].data()["title"]}"),
                      subtitle: Text("${snapShot.data!.docs[index].data()["desc"]}"),
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
          var collRef = firestore.collection("notes");
          collRef.add(NoteModel(title: _titleEditingController.text , desc: _descEditingController.text).toMap()
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


}


