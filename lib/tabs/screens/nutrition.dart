import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'food.dart';
import 'result1.dart';

class NutritionScreen extends StatefulWidget {
  createState() {
    return NutritionScreenState();
  }
}

class NutritionScreenState extends State<NutritionScreen> {
  List<Food> list;
  List<Food> selectedList;
  bool sort;
  double amountProts;
  double amountFats;
  double amountCarbs;
  double amountCal;
  double recommended;

  void initState() {
    sort = false;
    selectedList = [];
    list = Food.fetchList();
    super.initState();
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        list.sort((a, b) => a.name.compareTo(b.name));
      } else {
        list.sort((a, b) => b.name.compareTo(a.name));
      }
    }
  }

  onSelectedRow(bool selected, Food model) async {
    setState(() {
      if (selected) {
        selectedList.add(model);
      } else {
        selectedList.remove(model);
      }
    });
  }

  DataTable dataBody() {
    return DataTable(
      sortAscending: sort,
      sortColumnIndex: 0,
      columns: [
        DataColumn(
            label: Text('Название'),
            numeric: false,
            onSort: (columnIndex, ascending) {
              setState(() {
                sort != sort;
              });
              onSortColumn(columnIndex, ascending);
            }),
        DataColumn(
          label: Text('Белки'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Жиры'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Углеводы'),
          numeric: false,
        ),
        DataColumn(
          label: Text('Ккал'),
          numeric: false,
        ),
      ],
      rows: list
          .map(
            (e) => DataRow(
                selected: selectedList.contains(e),
                onSelectChanged: (b) {
                  onSelectedRow(b, e);
                },
                cells: [
                  DataCell(Text(e.name)),
                  DataCell(Text(e.proteins.toString())),
                  DataCell(Text(e.fats.toString())),
                  DataCell(Text(e.carbs.toString())),
                  DataCell(Text(e.calorie.toString())),
                ]),
          )
          .toList(),
    );
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Составьте свой рацион'),
        ),
        body: ListView(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: dataBody(),
            ),
            Row(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlineButton(
                  child: Text('Посчитать ${selectedList.length}'),
                  onPressed: () {
                    _calculate();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen1(amountProts, amountFats, amountCarbs,amountCal,recommended),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ],
        ));
  }

  _calculate() async {
    final prefs = await SharedPreferences.getInstance();
    recommended = prefs.getDouble('calorie');
    amountProts = 0.0;
    amountFats = 0.0;
    amountCarbs = 0.0;
    amountCal = 0.0;
    for (var s in selectedList) {
      amountProts += s.proteins;
      amountFats += s.fats;
      amountCarbs += s.carbs;
      amountCal += s.calorie;
    }
  }
}
