import 'package:flutter/material.dart';
import 'package:sci_calculator/Calculator/cal_ui.dart';
import 'package:sci_calculator/Converter/ConverterUI.dart';
import 'package:sci_calculator/Converter/Currency.dart';

import 'package:sci_calculator/HomeScreen/app_bar_cust.dart';

void main() => runApp(MaterialApp(
      home: CalSci(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/Currency": (context) => Currency(),
      },
    ));

class CalSci extends StatefulWidget {
  const CalSci({super.key});

  @override
  State<CalSci> createState() => _CalSciState();
}

class _CalSciState extends State<CalSci> with SingleTickerProviderStateMixin {
  //Creating a variable of type TabController
  late TabController _tabController;
  @override

  // initializing the _tabController

  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Passing _tabController to CustomAppBar Class which returns PreferredSizeWidget
      appBar: CustomAppBar(tabController: _tabController),

      //Using TabBarView to display the TabBar
      //have to use same controller: _tabController
      body: TabBarView(
        controller: _tabController,
        children: const [
          CalUI(),
          ConverterUI(),
        ],
      ),
    );
  }
}
