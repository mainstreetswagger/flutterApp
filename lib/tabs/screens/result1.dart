import 'package:flutter/material.dart';

class ResultScreen1 extends StatelessWidget{

  double chosen;
  double recommended;
  
  double prot;
  double fa;
  double car;
  ResultScreen1(double proteins, double fats, double carbs, double chosenCal, double recommededCal){
    this.chosen=chosenCal;
    this.recommended=recommededCal;
    this.prot=proteins;
    this.fa=fats;
    this.car=carbs;
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
      return Text('Рекоммендуемое количество ккал в день ${recommended}.'
      +'\nВы вырали рацион, который содержит ${chosen} ккал, ${prot} г, ${fa} г, ${car} г.'
      +'\nРазница которую вам нужно съесть : ${recommended-chosen} ккал');
      
      
    }
  );
}
}
