import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingPage(),
    );
  }
}

class SettingPage extends StatefulWidget{
  @override
  SettingList createState() => SettingList();
}

class SettingList extends State<SettingPage>{
  TimeOfDay _selectedTime = TimeOfDay(hour: 0, minute: 0);
  bool switchValue = false;
  bool setTimeValue = false;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // 가로 정렬을 오른쪽으로 설정
            children: [
              Text("Time Setting"),
              Switch(
                value: switchValue,
                onChanged: (value){
                  setState(() {
                    switchValue=value;
                    setTimeValue=value;
                  });
                },
              ),
            ],
          ),
          Opacity(
            opacity: setTimeValue? 1.0:0.3,
            child : InkWell(
              onTap: setTimeValue? (){
                _selectTime(context);
              } : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Text(
                    "시간설정",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    " ${_selectedTime.format(context)}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider( ),
          Text("버전"),
        ],
      ),
    );
  }
}