import 'package:flutter/material.dart';

import 'DayNightSwitch.dart';

void main() => runApp(MyApp());
bool isDark = true;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: isDark ? Brightness.dark : Brightness.light),
        darkTheme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Rive + Flutter"),
          ),
          body: Center(
            child: Container(
              child: DayNightSwitch(
                height: 70.0,
                width: 95.0,
                onSelection: (isCheck) {
                  print(isCheck);
                  setState(() {
                    isDark = !isCheck;
                  });
                },
              ),
            ),
          ),
        ));
  }
}
