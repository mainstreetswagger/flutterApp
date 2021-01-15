import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget{

  int w;
  double c;
  ResultScreen(int weight, double calorie){
    this.w=weight;
    this.c=calorie;
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
      return Text('Ваш вес : $w кг, вам нужно потреблять $c ккал в сутки согласно формуле Миффлина-Сан Жеора.');
      
    }
  );
}
}
