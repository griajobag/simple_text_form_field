import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_text_form_field/simple_text_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //define the controller
  SimpleTextFormFieldController controller =  SimpleTextFormFieldController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Usage"),
      ),
      body: Center(
        child:Column(
          children: [
            SimpleTextFormField(
              controller: controller,
              isRequired: true,
              type: InputTextType.ktp,
              errorTextSize: 8,
              maxLength: 16,
              placeHolder: "Input your name",
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  //to validate you just need do like this
                  if(controller.isValid){
                    log("Do your stuff");
                  }
                },
                child: const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child:  Text("Save", style: TextStyle(color: Colors.blue),),
                ),
              ),
            )
          ],
        ),
      ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
