import 'package:flutter/material.dart';
import 'products.dart';
import 'result2.dart';

class PricesScreen extends StatefulWidget {
  createState() {
    return PricesScreenState();
  }
}

class PricesScreenState extends State<PricesScreen> {
  List<Product> list;
  List<String> regions;
  List<Product> selectedList;
  int region = 0;
  double price;
  String names='';

  void initState() {
    selectedList = [];
    list = Product.fetchList();
    regions = Product.fetchRegions();
    super.initState();
  }

  onSelectedRow(bool selected, Product model) async {
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
      columns: [
        DataColumn(
          label: Text('Продукт'),
          numeric: false,
        ),
        DataColumn(
          label: Text(regions[0]),
          numeric: false,
        ),
        DataColumn(
          label: Text(regions[1]),
          numeric: false,
        ),
        DataColumn(
          label: Text(regions[2]),
          numeric: false,
        ),
        DataColumn(
          label: Text(regions[3]),
          numeric: false,
        ),
        DataColumn(
          label: Text(regions[4]),
          numeric: false,
        ),
        DataColumn(
          label: Text(regions[5]),
          numeric: false,
        ),
        DataColumn(
          label: Text(regions[6]),
          numeric: false,
        ),
        DataColumn(
          label: Text(regions[7]),
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
                  DataCell(Text(e.price[0].toString())),
                  DataCell(Text(e.price[1].toString())),
                  DataCell(Text(e.price[2].toString())),
                  DataCell(Text(e.price[3].toString())),
                  DataCell(Text(e.price[4].toString())),
                  DataCell(Text(e.price[5].toString())),
                  DataCell(Text(e.price[6].toString())),
                  DataCell(Text(e.price[7].toString())),
                ]),
          )
          .toList(),
    );
  }

  Widget regionField() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Место проживания',
            contentPadding: EdgeInsets.only(top: 35.0),
          ),
          items: [
            DropdownMenuItem<String>(
              child: Text(regions[0]),
              value: '0',
            ),
            DropdownMenuItem<String>(
              child: Text(regions[1]),
              value: '1',
            ),
            DropdownMenuItem<String>(
              child: Text(regions[2]),
              value: '2',
            ),
            DropdownMenuItem<String>(
              child: Text(regions[3]),
              value: '3',
            ),
            DropdownMenuItem<String>(
              child: Text(regions[4]),
              value: '4',
            ),
            DropdownMenuItem<String>(
              child: Text(regions[5]),
              value: '5',
            ),
            DropdownMenuItem<String>(
              child: Text(regions[6]),
              value: '6',
            ),
            DropdownMenuItem<String>(
              child: Text(regions[7]),
              value: '7',
            ),
          ],
          onChanged: (String value) {
            setState(() {
              region = int.parse(value);
            });
          },
          hint: Text('Выберите область где вы живете'),
        );
      },
    );
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Шоппинг'),
        ),
        body: ListView(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: dataBody(),
            ),
            regionField(),
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
                        builder: (context) => ResultScreen2(price, regions[region], names),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ],
        ));
  }

  _calculate(){
    price=0.0;
    for(var s in selectedList){
      price+=s.price[region];
      names=names+s.name+', ';
    }
    price=double.parse((price).toStringAsFixed(2));
  }
}
