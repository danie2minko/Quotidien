import 'package:flutter/material.dart';

class Textformfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  
  const Textformfield({super.key, 
  required this.hintText, 
  required this.controller,
  this.validator
  }
);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: TextFormField(
        decoration: InputDecoration(
           hintText: hintText,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.grey.shade300, width: 3), 
                      ),
      
                    focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                       borderSide: BorderSide(
                       color: Color.fromRGBO(249, 139, 66, 1.0),
                        width: 2,
                    ),
                  ),
                  hintStyle: TextStyle(
                   color: Colors.grey.shade300,
                 ),
              ),
      ),
    );
  }
}
