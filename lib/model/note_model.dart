class NoteModel{
  String title;
  String desc;

  NoteModel({
    required this.title,
    required this.desc,
});

  Map<String,dynamic> toMap (){

    return {
      "title" : title ,
      "desc" : desc ,
    };

  }

  factory NoteModel.fromMap (String title , String desc){

    return NoteModel(title: title, desc: desc);
  }


}