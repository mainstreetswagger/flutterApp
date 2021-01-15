import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'result.dart';

class DataScreen extends StatefulWidget {
  createState() {
    return DataScreenState();
  }
}

class DataScreenState extends State<DataScreen> {
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          nameField(),
          ageField(),
          weightField(),
          heightField(),
          genderField(),
          activityField(),
          Container(margin: EdgeInsets.only(top: 25.0)),
          submitButton(),
        ],
      ),
    );
  }

  String gender = 'М';
  String name;
  int age = 0;
  int weight = 0;
  int height = 0;
  double activity = 0.0;
  double calorie = 0.0;
  String selected;

  Widget nameField() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Фио',
          ),
          onChanged: (String newValue) {
            setState(() {
              name = newValue;
            });
          },
        );
      },
    );
  }

  Widget ageField() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Возраст',
            hintText: 'лет',
          ),
          onChanged: (String newValue) {
            setState(() {
              age = int.parse(newValue);
            });
          },
        );
      },
    );
  }

  Widget weightField() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Вес',
            hintText: 'кг',
          ),
          onChanged: (String newValue) {
            setState(() {
              weight = int.parse(newValue);
            });
          },
        );
      },
    );
  }

  Widget heightField() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Рост',
            hintText: 'см',
          ),
          onChanged: (String newValue) {
            setState(() {
              height = int.parse(newValue);
            });
          },
        );
      },
    );
  }

  Widget genderField() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Пол',
            contentPadding: EdgeInsets.only(top:35.0),
          ),
          
          onChanged: (String newValue) {
            setState(() {
              gender = newValue;
            });
          },
          items:
              <String>['М', 'Ж'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: Text('Выберите свой пол') ,
        );
      },
    );
  }

  Widget activityField() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Активность',
            contentPadding: EdgeInsets.only(top:35.0),
          ),
          
          items: [
            DropdownMenuItem<String>(
              child: Text('Минимальная активность'),
              value: '1.2',
            ),
            DropdownMenuItem<String>(
              child: Text('Слабая активность'),
              value: '1.375',
            ),
            DropdownMenuItem<String>(
              child: Text('Средняя активность'),
              value: '1.55',
            ),
            DropdownMenuItem<String>(
              child: Text('Высокая активность'),
              value: '1.725',
            ),
            DropdownMenuItem<String>(
              child: Text('Экстра-активность'),
              value: '1.9',
            ),
          ],
          onChanged: (String value) {
            setState(() {
              activity = double.parse(value);
            });
          },
          hint: Text('Выберите свою активность') ,
        );
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      child: Text('Сохранить'),
      color: Colors.blue,
      onPressed: () {
        _calculate();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(weight, calorie),
          ),
        );
      },
    );
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final keyName = 'name';
    final valueName = name;
    prefs.setString(keyName, valueName);

    final keyGender = 'gender';
    final valueGender = gender;
    prefs.setString(keyGender, valueGender);

    final keyAge = 'age';
    final valueAge = age;
    prefs.setInt(keyAge, valueAge);

    final keyHeight = 'height';
    final valueHeight = height;
    prefs.setInt(keyHeight, valueHeight);

    final keyWeight = 'weight';
    final valueWeight = weight;
    prefs.setInt(keyWeight, valueWeight);

    final keyActivity = 'activity';
    final valueActivity = activity;
    prefs.setDouble(keyActivity, valueActivity);

    final keyCalorie = 'calorie';
    final valueCalorie = calorie;
    prefs.setDouble(keyCalorie, valueCalorie);

  }

  _calculate() {
    //Доработанный вариант формулы Миффлина-Сан Жеора
    
    if(this.gender=='М'){
      this.calorie = this.activity*(10*this.weight+6.25*this.height-5*this.age+5);
    }
    else{
      this.calorie=this.activity*(10*this.weight+6.25*this.height-5*this.age-161);
    }

    calorie=double.parse((calorie).toStringAsFixed(2));
    _save();
  }

  
}
