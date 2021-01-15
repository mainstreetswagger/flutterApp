import 'package:flutter/material.dart';
import 'package:nutrition/tabs/screens/data.dart';
import 'nutrition.dart';
import 'prices.dart';
import 'info.dart';

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.computer)),
                Tab(icon: Icon(Icons.fastfood)),
                Tab(icon: Icon(Icons.monetization_on)),
                Tab(icon: Icon(Icons.info)),
              ],
            ),
            title: Text('Правильное питание'),
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
                  DataScreen(),
                ],
              ),
              NutritionScreen(),
              PricesScreen(),
              InfoScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
