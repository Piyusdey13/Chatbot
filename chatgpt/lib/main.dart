import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:lottie/lottie.dart';
void main(){
  Gemini.init(apiKey: "AIzaSyA-w8CmyHHf8ySfFb4_2aAbb8p7JezIqFY");
  runApp(Chatgpt());
}

class Chatgpt  extends StatefulWidget {


  @override
  State<Chatgpt> createState() => _ChatgptState();
}

class _ChatgptState extends State<Chatgpt> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController=TextEditingController();
  String respones="How can i help you?";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Row(
          children: [
            Icon(Icons.message),
            SizedBox(width: 10,),
            Text("Chatgpt")
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Welcome to chatgpt",style: TextStyle(fontSize: 25,color:Colors.black),),
        Lottie.asset("assets/lottie/lottie_robeot.json"),
         Expanded(child: SingleChildScrollView(
           child: Text(respones),
         ))
        ,Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: textEditingController,
                    decoration:  InputDecoration(
                      labelText: "Enter your message",
                    ),
                  ),

                ),
                SizedBox(width: 30,),
                ElevatedButton(onPressed: (){
                  Gemini.instance.prompt(parts: [
                    Part.text(textEditingController.text),
                  ]).then((value) {
                    setState(() {
                      respones=value!.output!;
                    });
                  }).catchError((e) {
                    print('error ${e}');
                  });
                }, child:Icon(Icons.send))
              ],
            )

          ]
        ),
      ),
    );
  }
}
