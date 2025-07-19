import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quotidien/components/buttons/black_button.dart';
import 'package:quotidien/components/textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //controllers
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    _confirmPwdController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  String? ValidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email est requis';
    }
    if (!isValidEmail(value)) {
      return 'Veuillez entrer une adresse email valide';
    }
    return null;
  }

  String? ValidatePwd(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est requis';
    }if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La confirmation du mot de passe est requise';
    }
    if (value != _pwdController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; 
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return 'Le mot de passe est trop faible.';
        case 'email-already-in-use':
          return 'Un compte existe déjà pour cet e-mail.';
        case 'invalid-email':
          return 'L\'adresse e-mail n\'est pas valide.';
        default:
          return 'Une erreur est survenue lors de l\'inscription.';
      }
    } catch (e) {
      return 'Une erreur inconnue est survenue.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
        
              //image
              Container(
                height: 180,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                  child: Image.asset('assets/images/signup.png'),
                ),
              ),
        
              //text sign in
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
        
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
                  SizedBox(height: 20,),
        
                Textformfield(
                  hintText: ' Confirm Password...', 
                  controller: _confirmPwdController,
                  validator: validateConfirmPassword,
                  ),
                  SizedBox(height: 40,),
        
              //button
               isLoading
                      ? CircularProgressIndicator(
                          color: Color.fromRGBO(249, 139, 66, 1.0),
                        )
                      :
              BlackButton(text: 'Sign Up', 
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
                              final error = await signUp(
                                email: email,
                                password: password,
                              );
        
                              if (!mounted) return;
        
                              setState(() {
                                isLoading = false;
                              });
        
                              if (error == null) {
                                Navigator.pushNamed(context, '/accountcreated');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                              }
                            } catch (e) {
                              if (!mounted) return;
        
                              setState(() {
                                isLoading = false;
                              });
        
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Une erreur est survenue')),
                              );
                            }
                          }
              ),
              SizedBox(height: 20),
        
              //text
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 90),
                child: Row(
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => {Navigator.pushNamed(context, '/signin')},
                      child: Text(
                        ' Sign In',
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
                padding: EdgeInsets.symmetric(vertical: 16),
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Row(
                  children: [
                    //Google
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 55,
                      width: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/images/google.png'),
                      ),
                    ),
                    SizedBox(width: 10),
        
                    //Apple
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 55,
                      width: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/images/apple.png'),
                      ),
                    ),
                    SizedBox(width: 10),
        
                    //facebook
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 55,
                      width: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/images/facebook.png'),
                      ),
                    ),
        
                    //SizedBox(width: 10,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
