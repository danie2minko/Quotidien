import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quotidien/components/buttons/black_button.dart';
import 'package:quotidien/components/textformfield.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //controllers
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  String? ValidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email est requis';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Veuillez entrer une adresse email valide';
    }
    return null;
  }

  String? ValidatePwd(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est requis';
    }
    return null;
  }

  Future <String?> SignIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Aucun utilisateur trouvé pour cet e-mail.';
      } else if (e.code == 'wrong-password') {
        return 'Mot de passe incorrect.';
      } else if (e.code == 'invalid-email') {
        return 'L\'adresse e-mail n\'est pas valide.';
      } else if (e.code == 'invalid-credential') {
        return 'Les identifiants fournis sont incorrects.';
      }
      return 'Une erreur est survenue lors de la connexion.';
    } catch (e) {
      return 'Une erreur est survenue';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(height: 80),
            
                //image
                Container(
                  height: 180,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    child: Image.asset('assets/images/signin.png'),
                  ),
                ),
            
                //text sign in
                Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
            
                //textformfield
                SizedBox(height: 40),
                 Textformfield(
                    hintText: 'Email...', 
                    controller: _emailController,
                    validator: ValidateEmail,
                    ),
                
                  SizedBox(height: 20,),
            
                 Textformfield(
                    hintText: 'Password...', 
                    controller: _pwdController,
                    validator: ValidatePwd,
                    ),
                
                  SizedBox(height: 40,),
            
            
                //button
                 isLoading
                      ? CircularProgressIndicator(
                          color: Color.fromRGBO(249, 139, 66, 1.0),
                        )
                      :
                BlackButton(text: 'Sign In', 
                onTap: () async {
                            if (!_formkey.currentState!.validate()) {
                              return;
                            }
            
                            setState(() {
                              isLoading = true;
                            });
            
                            final email = _emailController.text.trim();
                            final password = _pwdController.text.trim();
            
                            try {
                              final error = await SignIn(
                                email: email,
                                password: password,
                              );
            
                              if (!mounted) return;
            
                              setState(() {
                                isLoading = false;
                              });
            
                              if (error == null) {
                                Navigator.pushNamed(context, '/homepage');
                              } else {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text(error)));
                              }
                            } catch (e) {
                              if (!mounted) return;
            
                              setState(() {
                                isLoading = false;
                              });
            
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Une erreur est survenue'),
                                ),
                              );
                            }
                          },
                ),
                SizedBox(height: 10,),
            
                //text
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 90),
                  child: Row(
                    children: [
                      Text(
                        'Do not have an account?',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () => {Navigator.pushNamed(context, '/signup')},
                        child: Text(
                          ' Sign Up',
                          style: TextStyle(
                            color: Color.fromRGBO(249, 139, 66, 1.0),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            
                //divider
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey)),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                        child: Text(
                          'or sign in with',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                ),
            
                //social media
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Image.asset(
                                'assets/images/google.png',
                                height: 25,
                                width: 25,
                              ),
                            ),
                            Text('Sign Up with Google'),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Image.asset(
                                'assets/images/apple.png',
                                height: 25,
                                width: 25,
                              ),
                            ),
                            Text('Sign Up with Aplle'),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Image.asset(
                                'assets/images/facebook.png',
                                height: 25,
                                width: 25,
                              ),
                            ),
                            Text('Sign Up with Facebook'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
