// import 'package:cubit173/list_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'counter_cubit.dart';
//
// class NextPage extends StatelessWidget {
//   bool isUpdate;
//   int mIndex;
//   String mTitle;
//   String mDesc;
//
//   NextPage(
//       {this.isUpdate = false,
//         this.mIndex = 0,
//         this.mTitle = "",
//         this.mDesc = ""});
//
//   var titleController = TextEditingController();
//   var descController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     titleController.text = mTitle;
//     descController.text = mDesc;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Next'),
//       ),
//       body: Column(
//         children: [
//           Text(isUpdate ? 'Update Note' : 'Add Note'),
//           TextField(
//             controller: titleController,
//           ),
//           TextField(
//             controller: descController,
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 if (titleController.text.isNotEmpty &&
//                     descController.text.isNotEmpty) {
//                   var mNote = {
//                     "title": titleController.text.toString(),
//                     "desc": descController.text.toString(),
//                   };
//
//                   if (isUpdate) {
//                     ///update
//                     BlocProvider.of<ListCubit>(context)
//                         .updateNote(mNote, mIndex);
//                   } else {
//                     ///add
//                     BlocProvider.of<ListCubit>(context).addNote(mNote);
//                   }
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text(isUpdate ? 'Update' : 'Add'))
//         ],
//       ),
//     );
//   }
// }
