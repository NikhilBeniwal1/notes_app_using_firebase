// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'notes_state.dart';
//
// class NotesCubit extends Cubit<NotesState> {
//   NotesCubit() : super(NotesInitial());
// }
//
//
// import 'dart:async';
// import 'dart:math';
//
// import 'package:cubit173/list_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ListCubit extends Cubit<ListState>{
//   ListCubit() : super(ListState(mData: []));
//
//
//   /// addNote
//   void addNote(Map<String, dynamic> newNote){
//     emit(ListState(mData: state.mData, isLoading: true));
//     Timer(Duration(seconds: 5), () {
//       var random = Random().nextInt(100);
//       print(random);
//       if(random%5==0){
//         //error
//         emit(ListState(mData: state.mData, isLoading: false, isError: true, errorMsg: "Data not Added"));
//       } else {
//         var currData = state.mData;
//         currData.add(newNote);
//         emit(ListState(mData: currData, isLoading: false, isError: false));
//       }
//     });
//
//   }
//
//   /// updateNote
//   void updateNote(Map<String, dynamic> updateNote, int index){
//     var currData = state.mData;
//     currData[index] = updateNote;
//
//     emit(ListState(mData: currData));
//
//   }
//
//   /// deleteNote
//   void deleteNote(int index){
//     var currData = state.mData;
//     currData.removeAt(index);
//
//     emit(ListState(mData: currData));
//   }
//
//
// }