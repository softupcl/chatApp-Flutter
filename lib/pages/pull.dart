import 'package:flutter/material.dart';

class PullPage extends StatefulWidget {
  @override
  _PullPageState createState() => _PullPageState();
}

class _PullPageState extends State<PullPage> {
  List<String> data = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter ListView"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2));
            updateData();
          },
          child: ListView(
            children: List.generate(
              data.length,
              (index) => Card(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(data[index]),
                ),
              ),
            ),
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
            itemExtent: 50,
          ),
          color: Colors.white,
          backgroundColor: Colors.purple,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
        ));
  }

  void updateData() {
    int i = data.length + 1;
    data.add("Item $i");
    setState(() {});
  }
}
