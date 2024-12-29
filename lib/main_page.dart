import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revise1/enter_notes_alert_dialog.dart';
import 'package:revise1/main.dart';
import 'package:revise1/notes_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  void delete(String note){
    Provider.of<notesProvider>(context,listen: false).deleteNotes(note);
  }

  void logout()async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeOrRegister()));  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<notesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: ()async=> logout() )
        ],
        
      ),
      body: Container(
          child:ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder:(context,index){
              return ListTile(
                title:  Text(provider.notes[index]),
                trailing: IconButton(icon: const Icon(Icons.delete), onPressed:()=>delete(provider.notes[index]) )
                );
            }
      ),),
      floatingActionButton: ElevatedButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (context) {
              return EnterDetailsAlertDialog();
            });
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.amber),
        ), 
        child: Icon(Icons.add, size:20,color: Colors.black)
        )
    );
    
  }
}