import 'package:box_tab_indicator/box_tab_indicator.dart';
import 'package:flutter/material.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Box Tab Indicator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleTabPage(),
    );
  }
}

class ExampleTabPage extends StatefulWidget {
  ExampleTabPage({Key key}) : super(key: key);

  _TabState createState() => _TabState();
}

class _TabState extends State<ExampleTabPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    new Tab(text: "First"),
    new Tab(text: "Second"),
    new Tab(text: "Third")
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'BoxTabIndicatorExample',
          ),
          bottom: TabBar(
            controller: _tabController,
            indicator: BoxTabIndicator(indicatorColor: Colors.lightBlueAccent),
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((tab) {
            return Container(
              color: Colors.lightBlueAccent,
              alignment: Alignment.center,
              child: Text(
                tab.text,
                style: TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
