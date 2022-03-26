import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       children: [
         Container(
           color: Colors.red,
           height: MediaQuery.of(context).size.height*0.1,
           width: double.infinity,
           child: Row(
             children: const [
               Text("Social", style: TextStyle(
                 fontSize: 20,
                 color: Colors.white
               ),),
               Text('X', style: TextStyle(
                 fontSize: 23,
                 color: Colors.white
               ),)
             ],
           ),
         )
       ],
     ),
    );
  }
}
