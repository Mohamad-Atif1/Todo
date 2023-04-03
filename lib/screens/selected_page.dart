import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo/to_do_data.dart';

class SelectedPage extends StatefulWidget {
  const SelectedPage({super.key});

  @override
  State<SelectedPage> createState() => _SelectedPageState();
}

class _SelectedPageState extends State<SelectedPage> {
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments! as Map;
    var text = (data['todo'] as ToDoData).task;

    return Scaffold(
      body: Text(
        text!,
        style: TextStyle(color: Colors.black, fontSize: 66),
      ),
    );
  }
}
