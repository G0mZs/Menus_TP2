import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tp2_amov/menu.dart';
import 'package:http/http.dart' as http;
import 'package:tp2_amov/screens/main.dart';

class MenuPage extends StatefulWidget{

  final Menu menu;
  const MenuPage(this.menu, {super.key});

  @override
  State<StatefulWidget> createState() {
      return MenuPageState(this.menu);
  }

}

class MenuPageState extends State<MenuPage> {

  Menu menu;
  MenuPageState(this.menu);
  TextEditingController soupController = TextEditingController();
  TextEditingController fishController = TextEditingController();
  TextEditingController meatController = TextEditingController();
  TextEditingController vegController = TextEditingController();
  TextEditingController desertController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFb7410e),
        elevation: 0,
        title: Text(menu.weekDay,style: const TextStyle(fontSize: 20)),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Color(0xFFF5F5DC)),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
          FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: TextFormField(
                  controller: soupController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      labelText: "Soup",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: menu.soup,
                      hintMaxLines: 4,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: TextFormField(
                  controller: fishController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      labelText: "Fish",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: menu.fish,
                      hintMaxLines: 4,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: TextFormField(
                  controller: meatController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      labelText: "Meat",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: menu.meat,
                      hintMaxLines: 4,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: TextFormField(
                  controller: vegController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      labelText: "Vegetarian",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: menu.vegetarian,
                      hintMaxLines: 4,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: TextFormField(
                  controller: desertController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      labelText: "Desert",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: menu.desert,
                      hintMaxLines: 4,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(child: ElevatedButton(onPressed: () {
                      resetData();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const MyHomePage(title: 'Flutter Demo Home Page',)));
                    },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFb7410e),
                          padding: const EdgeInsets.all(15),
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      child: const Text("Reset"),)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(child: ElevatedButton(onPressed: () {
                      postData();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const MyHomePage(title: 'Flutter Demo Home Page',)));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFb7410e),
                          padding: const EdgeInsets.all(15),
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      child: const Text("Submit"),)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5DC),
      );
  }

  Future<http.Response?> postData() async{

    var nullCount = 0;
    String soupText,fishText,meatText,vegText,desertText;

    if(soupController.text.isEmpty){
      soupText = menu.soup;
      nullCount++;

    }else {
      soupText = soupController.text;
    }

    if(fishController.text.isEmpty){
      fishText = menu.fish;
      nullCount++;

    }else{
      fishText = fishController.text;
    }

    if(meatController.text.isEmpty){
      meatText = menu.meat;
      nullCount++;

    }
    else{
      meatText = meatController.text;
    }

    if(vegController.text.isEmpty){
      vegText = menu.vegetarian;
      nullCount++;

    }else{
      vegText = vegController.text;
    }

    if(desertController.text.isEmpty){
      desertText = menu.desert;
      nullCount++;

    }else{
      desertText = desertController.text;
    }

    if(nullCount == 5){
      return null;
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/menu'),
      headers:{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({
          "img":null,
          "weekDay":menu.weekDay,
          "soup":soupText,
          "fish":fishText,
          "meat":meatText,
          "vegetarian":vegText,
          "desert":desertText

      })
    );

    return response;
  }

  Future<http.Response?> resetData() async{

    final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/menu'),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8'
        },

    );
    print(response.body);
    return response;
  }

}



