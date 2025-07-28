import 'package:flutter/material.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color.fromRGBO(249, 139, 66, 1.0),
        child: Column(
            children: [
                SizedBox(height: 40,),
                Center(child: Image.asset('assets/images/white_smile.png')),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                  child: ListTile(
                      title: Text('HOME', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      leading: Icon(Icons.home, color: Colors.white),
                      onTap: ()=>{
                        Navigator.pushReplacementNamed(context, '/homepage')
                      },
                  ),
                ),

                Padding(
                    padding: EdgeInsets.only(left: 10),
                  child: ListTile(
                      title: Text('SETTINGS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      leading: Icon(Icons.settings, color: Colors.white),
                      onTap: ()=>{},
                  ),
                ),

                Padding(
                    padding: EdgeInsets.only(left: 10),
                  child: ListTile(
                      title: Text('HISTORY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      leading: Icon(Icons.history, color: Colors.white),
                      onTap: ()=>{
                        Navigator.pushReplacementNamed(context, '/hitory')
                      },
                  ),
                ),

                Padding(
                    padding: EdgeInsets.only(left: 10),
                  child: ListTile(
                      title: Text('PROFIL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      leading: Icon(Icons.person, color: Colors.white),
                      onTap: ()=>{},
                  ),
                )
            ],
        ),
    );
  }
}