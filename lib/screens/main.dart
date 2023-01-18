import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp2_amov/menu.dart';
import 'package:tp2_amov/screens/edit_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: const Color(0x44000000),
          elevation: 0,
          title: const Text('Menu', style: TextStyle(fontSize: 20)),
          centerTitle: true,
          titleTextStyle: const TextStyle(color: Colors.white),
        ),
        body: Center(
          child: FutureBuilder<List<Menu>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Menu> menu = snapshot.data as List<Menu>;
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/cooking.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListView.builder(
                      itemCount: menu.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            color: const Color(0xFFF5F5DC),
                            elevation: 6,
                            margin: const EdgeInsets.fromLTRB(
                                7.0, 7.0, 7.0, 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MenuPage(menu[index])));
                              },
                              title: Row(
                                children: <Widget>[
                                  Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFb7410e),
                                        borderRadius: BorderRadius.circular(
                                            60 / 2)
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  SizedBox(
                                    width: 250,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[
                                        const SizedBox(height: 6,),
                                        showTextUpdate(menu[index]),
                                        const SizedBox(height: 10,),
                                        Text("Soup: ${menu[index].soup}",
                                            maxLines: null,
                                            style: const TextStyle(fontSize: 14,
                                                color: Colors.blueGrey)),
                                        const SizedBox(height: 13,),
                                        const Text("Click for more info...",
                                            maxLines: null,
                                            style: TextStyle(fontSize: 17,
                                                color: Colors.black)),
                                        const SizedBox(height: 6,),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        floatingActionButton: floatingButton(),
        backgroundColor: Colors.white70);
  }

  Future<List<Menu>> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/menu'));
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    Menu monday, tuesday, wednesday, thursday, friday;

    if (data["MONDAY"]["update"] != null) {
      monday = Menu.fromJson(data["MONDAY"]["update"]);
      monday.update = true;
    }
    else {
      monday = Menu.fromJson(data["MONDAY"]["original"]);
    }

    if (data["TUESDAY"]["update"] != null) {
      tuesday = Menu.fromJson(data["TUESDAY"]["update"]);
      tuesday.update = true;
    }
    else {
      tuesday = Menu.fromJson(data["TUESDAY"]["original"]);
    }

    if (data["WEDNESDAY"]["update"] != null) {
      wednesday = Menu.fromJson(data["WEDNESDAY"]["update"]);
      wednesday.update = true;
    }
    else {
      wednesday = Menu.fromJson(data["WEDNESDAY"]["original"]);
    }

    if (data["THURSDAY"]["update"] != null) {
      thursday = Menu.fromJson(data["THURSDAY"]["update"]);
      thursday.update = true;
    }
    else {
      thursday = Menu.fromJson(data["THURSDAY"]["original"]);
    }

    if (data["FRIDAY"]["update"] != null) {
      friday = Menu.fromJson(data["FRIDAY"]["update"]);
      friday.update = true;
    }
    else {
      friday = Menu.fromJson(data["FRIDAY"]["original"]);
    }

    final datetime = DateTime.parse(DateTime.now().toString());
    final weekDay = datetime.weekday;

    List<Menu> menu = [];

    if (weekDay == DateTime.monday || weekDay == DateTime.sunday ||
        weekDay == DateTime.saturday) {
      menu = [monday, tuesday, wednesday, thursday, friday];
    }
    else if (weekDay == DateTime.tuesday) {
      menu = [tuesday, wednesday, thursday, friday, monday];
    } else if (weekDay == DateTime.wednesday) {
      menu = [wednesday, thursday, friday, monday, tuesday];
    } else if (weekDay == DateTime.thursday) {
      menu = [thursday, friday, monday, tuesday, wednesday];
    } else if (weekDay == DateTime.friday) {
      menu = [friday, monday, tuesday, wednesday, thursday];
    }
    return menu;
  }

  _refreshAction() {
    setState(() {
      fetchData();
    });
  }

  Widget floatingButton() {
    return FloatingActionButton(
        onPressed: _refreshAction,
        child: const Icon(Icons.refresh));
  }

  showTextUpdate(Menu menu) {
    if (menu.update == true) {
      return Text(
          menu.weekDay + " - UPDATED", style: const TextStyle(fontSize: 20));
    } else {
      return Text(menu.weekDay, style: const TextStyle(fontSize: 20));
    }
  }


}
