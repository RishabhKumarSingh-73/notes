import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:revise1/notes_provider.dart';

class EnterDetailsAlertDialog extends StatefulWidget {
  const EnterDetailsAlertDialog({super.key});

  @override
  State<EnterDetailsAlertDialog> createState() => _EnterDetailsAlertDialogState();
}

class _EnterDetailsAlertDialogState extends State<EnterDetailsAlertDialog> {

  final TextEditingController note = TextEditingController();
    String? userid = FirebaseAuth.instance.currentUser!.email;


  void onClick(String note)async{
    await FirebaseFirestore.instance.collection('users').doc(userid).update({
      'notes': FieldValue.arrayUnion([note])
    });
    // Provider.of<notesProvider>(context,listen: false).addNotes(note);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter note'),
      actions: [
        TextField(
          controller: note,
          decoration: const InputDecoration(
            hintText: "enter the text",
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 15
            ),
            fillColor: Colors.white,
            
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.amber,
                width: 2.0,
                
              ),
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.amber,
                width: 2.0,
                
              ),
              borderRadius: BorderRadius.all(Radius.circular(15))
            )
          )
        ),

        //
        ElevatedButton(
          onPressed:()=> onClick(note.text),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.amber),
          ), 
          child: const Text('add',style: TextStyle(color: Colors.black),),
        )
      ],
    );
  }
}