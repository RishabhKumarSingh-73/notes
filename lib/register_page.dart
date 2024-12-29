import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revise1/login_page.dart';
import 'package:revise1/main.dart';
import 'package:revise1/main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onClick() async{
    final userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    if(userCredentials.user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeOrRegister()));
      }
    print(userCredentials);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('register'),
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
          onPressed:()async=> onClick(),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.amber),
          ), 
          child: const Text('register',style: TextStyle(color: Colors.black),),
        ),

        //register page navigation
        Text("already registered ? "),
        TextButton(
          onPressed: ()=> Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage())
                          ),
 
          child: Text("login here")
          )
          ],
        )
      ),
    );
  }
}