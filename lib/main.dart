import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Modeltask.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primaryColor: Colors.grey,
        unselectedWidgetColor: Colors.tealAccent,
        colorScheme: const ColorScheme.dark(),
      ),
      home: const MyHomePage(title: 'To-do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ModelTask> task=[];
  int i=0;


  localStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("tasks", jsonEncode(task));

  }

  getFromLocal() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      List<dynamic> temp = jsonDecode(prefs.getString("tasks")!);
      for ( var t in temp){
        task.add(ModelTask(t['text'],t['isSelected']));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getFromLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

      localStorage();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(task.length, (i) =>
           Dismissible(
             key: ValueKey(task[i]),
             background: Container(
               color: Colors.teal,
             ),
             onDismissed: (DismissDirection d){
               setState(() {
                 task.removeAt(i);
               });
             },
             child: Container(
               margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
               child: ListTile(
                 title: TextField(
                   decoration: InputDecoration(border: InputBorder.none,
                   hintText: task[i].text,hintStyle: TextStyle(color: Colors.black)),
                   cursorColor: Colors.black,
                   style: const TextStyle(fontSize: 20,color: Colors.black),
                   onChanged: (String txt){
                     task[i].text=txt;
                   },
                 ),
                 trailing: Checkbox(
                   value: task[i].isSelected,
                   onChanged: (bool? value){
                     setState(() {
                       task[i].isSelected=value;
                     });
                   },
                     ),
                   tileColor: Colors.white,
                 ),
               ),
           ),
           )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          int i=task.length+1;
          setState(() {
            task.add(ModelTask('Type task',false));
          });
        },
       // tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
