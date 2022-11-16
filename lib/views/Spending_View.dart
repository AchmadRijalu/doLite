import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DoneView extends StatelessWidget {
  static final routeNames = "Spending";
  const DoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text("data")],
        )),
      ),
    );
  }
}
