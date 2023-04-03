import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:todo/to_do_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../to_do_data.dart';
import '../constants/app_color.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDoData> toDoData = [];
  List<ToDoData> foundData = [];
  bool resize = false; // when click searchbar , addText bar should disapper
  late SharedPreferences sharedPreferences;
  TextEditingController addTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initSharedPre();
  }

  void initSharedPre() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<dynamic> pre =
        JsonDecoder().convert(sharedPreferences.getString('myList')!);

    List<ToDoData> temp = [];
    for (var element in pre) {
      temp.add(ToDoData(task: element['task'], isDone: element['isDone']));
    }
    toDoData = temp;

    setState(() {
      foundData = toDoData;
    });
  }

  void saveList() {
    String jsonString = JsonEncoder().convert(toDoData);

    sharedPreferences.setString('myList', jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundCR,
      resizeToAvoidBottomInset: resize,
      appBar: _buildAppBar(),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Column(
            children: [
              searchBar(),
              toDoListWidget(),
            ],
          ),
          addToDoWidget()
        ],
      ),
    );
  }

  Align addToDoWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
              decoration: BoxDecoration(
                  color: whiteCR,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black87)),
              child: TextField(
                onTap: () {
                  setState(() {
                    resize = true;
                  });
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                  hintText: "Add a Task",
                  hintStyle: TextStyle(fontSize: 22),
                ),
                controller: addTaskController,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 9, right: 10),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  toDoData.insert(0, ToDoData(task: addTaskController.text));
                  saveList();
                });
              },
              style: ElevatedButton.styleFrom(
                elevation: 10,
              ),
              child: const Text(
                "+",
                style: TextStyle(fontSize: 40),
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded toDoListWidget() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            allToDos(),
            for (ToDoData data in foundData)
              ToDoCard(
                data: data,
                delete: () {
                  setState(() {
                    // remove the data from sharedprefrence also
                    toDoData.remove(data);
                    // saving the list after removing the data
                    //to remove the data from sharedprefrence also
                    saveList();
                  });
                },
                onTap: () {
                  setState(() {
                    data.isDone = !data.isDone;
                    //    Navigator.pushNamed(context, 'selected_page', arguments: {
                    //    'todo': data,
                    //});
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Container allToDos() {
    return Container(
        margin: const EdgeInsets.only(left: 20, top: 50),
        child: const Text(
          "All ToDos",
          style: TextStyle(fontSize: 46, fontWeight: FontWeight.w500),
        ));
  }

  Container searchBar() {
    return Container(
      decoration: BoxDecoration(
        color: whiteCR,
        borderRadius: BorderRadius.circular(22),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      child: TextField(
        onTap: () {
          setState(() {
            resize = false;
          });
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(12),
            prefixIcon: Icon(
              Icons.search,
              color: searchIconCR,
            ),
            hintText: "search",
            hintStyle: const TextStyle(fontSize: 22)),
        onChanged: (value) {
          searchBoxFunction(value);
        },
      ),
    );
  }

  void searchBoxFunction(String searchBoxValue) {
    List<ToDoData> result = [];
    if (searchBoxValue.isEmpty) {
      result = toDoData;
    } else {
      result = toDoData
          .where((element) => element.task!
              .toLowerCase()
              .contains(searchBoxValue.toLowerCase()))
          .toList();

      // instead of using where , we can write it as :
      //
      /*for (var data in toDoData) {
        if (data.task!.toLowerCase().contains(searchBoxValue.toLowerCase())) {
          result.add(ToDoData(task: data.task));
        }
      }*/
      //

    }
    setState(() {
      foundData = result;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Container(
        margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(
                Icons.menu,
                color: Colors.black87,
                size: 30,
              ),
              CircleAvatar(
                foregroundImage: AssetImage("assest/th.jpg"),
              )
            ]),
      ),
      backgroundColor: backgroundCR,
      elevation: 0,
    );
  }
}
