import 'package:flutter/material.dart';

class ConverterUI extends StatelessWidget {
  const ConverterUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Row(children: [
            addNewIcon(Icons.currency_exchange_outlined, "Currency", context),
            addNewIcon(Icons.swap_vert, "Length", context),
            addNewIcon(Icons.monitor_weight_outlined, "Mass", context)
          ])
        ],
      ),
    );
  }

  Expanded addNewIcon(IconData iconsA, String name, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 120,
        // color: Colors.amber,
        child: TextButton.icon(
          icon: Icon(
            iconsA,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/$name"); //Y context error
          },
          label: Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
