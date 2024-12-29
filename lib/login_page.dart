import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revise1/main.dart';
import 'package:revise1/main_page.dart';
import 'package:revise1/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onclick() async{
    try{
      final UserCredential userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      if(userCredentials.user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeOrRegister()));
      }
      print(userCredentials);
    }catch(e){
      print(e);
    }

  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          children: [

            //email textfield
            TextField(
          controller: emailController,
          decoration: const InputDecoration(
            hintText: "email",
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

        //password textfield
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            hintText: "password",
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

        //login button
        ElevatedButton(
          onPressed:()async=> onclick(),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.amber),
          ), 
          child: const Text('login',style: TextStyle(color: Colors.black),),
        ),

        //register page navigation
        Text("have'nt registered "),
        TextButton(
          onPressed: ()=> Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterPage())
                          ), 
          child: Text("click here")
          )
          ],
        )
      ),
    );
  }
}