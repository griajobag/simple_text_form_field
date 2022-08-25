import 'dart:developer';

import 'package:example/item_model.dart';
import 'package:flutter/material.dart';
import 'package:simple_text_form_field/simple_contants.dart';
import 'package:simple_text_form_field/simple_text_form_field.dart';
import 'package:simple_text_form_field/simple_text_form_field_date.dart';
import 'package:simple_text_form_field/simple_text_form_field_dropdown.dart';

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
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //define the controller
  SimpleTextFormFieldController controller = SimpleTextFormFieldController();
  SimpleTextFormFieldDateController controllerDate =
      SimpleTextFormFieldDateController();
  SimpleTextFormFieldDateController controllerTime =
      SimpleTextFormFieldDateController();
  SimpleTextFormFieldDropDownController<ItemModel> controllerDropdown =
      SimpleTextFormFieldDropDownController();

  String? text = "";
  String? date = "";
  String? time = "";
  String? objectSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Usage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SimpleTextFormField(
              controller: controller,
              isRequired: true,
              errorTextSize: 8,
              maxLength: 12,
              label: "Name",
              placeHolder: "Input your name",
            ),
            const Padding(padding: EdgeInsets.all(10)),
            SimpleTextFormFieldDate(
              isRequired: true,
              fillColor: Colors.transparent,
              controller: controllerDate,
              label: "Your birthday",
            ),
            const Padding(padding: EdgeInsets.all(10)),
            SimpleTextFormFieldDate(
              isRequired: true,
              fillColor: Colors.transparent,
              controller: controllerTime,
              type: InputDatetimeType.time,
              label: "Your Time",
            ),
            const Padding(padding: EdgeInsets.all(10)),
            SimpleTextFormFieldDropDown<ItemModel>(
              controller: controllerDropdown,
              required: true,
              valueItem: (e)=> e.title!,
              listItem: [
                ItemModel(
                    title: "First Title",
                    dateTime: DateTime.now(),
                    desc: "This is the first description of title"),
                ItemModel(
                    title: "Second Title",
                    dateTime: DateTime.now(),
                    desc: "This is the first description of title"),
                ItemModel(
                    title: "Third Title",
                    dateTime: DateTime.now(),
                    desc: "This is the first description of title"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  //to validate you just need do like this
                  if (controller.isValid &&
                      controllerDate.isValid &&
                      controllerTime.isValid &&
                  controllerDropdown.isValid) {
                    setState(() {
                      text = controller.value;
                      date = SimpleConstants.dateToString(controllerDate.value,
                          format: "dd/MM/yyyy");
                      time = controllerTime.value.format(context);
                    });
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text("Text :${text!}, Date : ${date!}, Time : ${time!}"),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
