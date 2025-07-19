import 'package:flutter/material.dart';
import 'package:quotidien/components/buttons/black_button.dart';
import 'package:quotidien/components/buttons/orange_button.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsetsGeometry.only(top: 150)),
            //welcome text
              Center(
                child: Text('Welcome',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(249, 139, 66, 1.0)
                ),
                ),
              ),
        
            //image
             Container(
              height: 300,
               child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 30),
                child: Image.asset('assets/images/orange_smile.png',)
                ),
             ),
        
            //page text
              Text("Sign Up or Login on Quotidien""\n""to Continue",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.grey.shade300,
              ),
              ),
              SizedBox(height: 20,),

            //buttons
            OrangeButton(
              text: 'Create Account',
              onTap: ()=>{
                Navigator.pushNamed(context, '/signup')
              },
            ),
            BlackButton(
              text: 'Always have an Account', 
              onTap: ()=>{
                Navigator.pushNamed(context, '/signin')
              },
            )
          ],
        ),
      ),
    );
  }
}