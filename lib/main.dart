import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revise1/firebase_options.dart';
import 'package:revise1/login_page.dart';
import 'package:revise1/main_page.dart';
import 'package:revise1/notes_provider.dart';
import 'package:revise1/register_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
//.....

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => notesProvider(),
      child: MaterialApp(
        title: 'Notes App',
        home: HomeOrRegister(),                
      ),
    );
  }
}

class HomeOrRegister extends StatefulWidget {
  const HomeOrRegister({super.key});

  @override
  State<HomeOrRegister> createState() => _HomeOrRegisterState();
}

class _HomeOrRegisterState extends State<HomeOrRegister> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(), 
          builder: (context, snapshots){
            if(snapshots.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(snapshots.hasData){
              return const MainPage();
            }
            
            return const RegisterPage();
            
          }
          );
  }
}