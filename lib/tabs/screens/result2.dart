import 'package:flutter/material.dart';

class ResultScreen2 extends StatelessWidget{

  double amount;
  String region;
  String names;
  ResultScreen2(double price, String place, String products){
    this.amount=price;
    this.region=place;
    this.names=products;
  }

  Widget build(context){
    return Scaffold(
      body:Container(
      margin:EdgeInsets.all(20.0),
      child:Center(
        
        child:          resultText(),
        
      ),
    ),
    );
  }


Widget resultText(){
  return StreamBuilder(
    builder:(context,snapshot){
      return Text('Вы выбрали следующие продукты: ${names}. '
      +'\nСумма товаров составит ${amount} сом в ${region}.');
      
      
    }
  );
}
}
