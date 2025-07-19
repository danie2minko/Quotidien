import 'package:flutter/material.dart';

class OrangeButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const OrangeButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(249, 139, 66, 1.0),
          ),
          child: Center(
            child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.black
            ),
            ),
          ),
        ),
      ),
    );
  }
}
