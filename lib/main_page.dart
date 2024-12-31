import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:revise1/enter_notes_alert_dialog.dart';
import 'package:revise1/main.dart';
// import 'package:revise1/notes_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String? userid = FirebaseAuth.instance.currentUser!.email;

  void delete(String note){
    FirebaseFirestore.instance.collection('users').doc(userid).update({
      'notes': FieldValue.arrayRemove([note])
    });
    // Provider.of<notesProvider>(context,listen: false).deleteNotes(note);
  }

  void logout()async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeOrRegister()));  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<notesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: ()async=> logout() )
        ],
        
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(userid).snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(!snapshot.hasData){
            return Text("no data");
          }

          final data = snapshot.data!.data() as Map<String,dynamic>;
          final notes = (data['notes'] as List<dynamic>).map((ele)=> ele.toString()).toList();
          return Container(
            child:ListView.builder(
              itemCount: notes.length,
              itemBuilder:(context,index){
                return ListTile(
                  title:  Text(notes[index]),
                  trailing: IconButton(icon: const Icon(Icons.delete), onPressed:()=>delete(notes[index]) )
                  );
              }
        ),);
          }
      ),
        
      
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