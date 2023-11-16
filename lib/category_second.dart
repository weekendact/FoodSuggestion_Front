// category_second.dart
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  final List<String> categoryfirst; // categoryfirst 추가

  NextPage(this.categoryfirst);

  @override
  _NextPageState createState() => _NextPageState(categoryfirst);
}

class _NextPageState extends State<NextPage> {
  List<String> categoryfirst;
  List<String> categorysecond = []; // categorysecond를 초기화

  _NextPageState(this.categoryfirst);

  @override
  Widget build(BuildContext context) {
    String categoryText = categoryfirst.join(',');
    return Scaffold(
        appBar: AppBar(
          title: Text('$categoryText'),
        ),
        body: Center(
          child: Column(
              children: <Widget>[
                CheckboxListTile(
                  title: Text('밥'),
                  value: categorysecond.contains('밥'),
                  onChanged: (newValue) {
                    setState(() {
                      if (newValue == true) {
                        categorysecond.add('밥');
                      } else {
                        categorysecond.remove('밥');
                      }
                    });
                    },
                ),
                CheckboxListTile(
                  title: Text('면'),
                  value: categorysecond.contains('면'),
                  onChanged: (newValue) {
                    setState(() {
                      if (newValue == true) {
                        categorysecond.add('면');
                      } else {
                        categorysecond.remove('면');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                    title: Text('빵'),
                    value: categorysecond.contains('빵'),
                    onChanged: (newValue) {
                      setState(() {
                        if (newValue == true) {
                          categorysecond.add('빵');
                        } else {
                          categorysecond.remove('빵');
                        }
                      });
                    }
                ),
                CheckboxListTile(
                  title: Text('떡'),
                  value: categorysecond.contains('떡'),
                  onChanged: (newValue) {
                    setState(() {
                      if (newValue == true) {
                        categorysecond.add('떡');
                      } else {
                        categorysecond.remove('떡');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('고기'),
                  value: categorysecond.contains('고기'),
                  onChanged: (newValue) {
                    setState(() {
                      if (newValue == true) {
                        categorysecond.add('고기');
                      } else {
                        categorysecond.remove('고기');
                      }
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        },
                      child: Text('이전 페이지로'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // "다음 페이지로" 버튼이 눌렸을 때 수행될 작업에 대한 논리를 추가하세요.
                      },
                      child: Text('다음 페이지로'),
                    ),
                  ],
                ),
              ],
          ),
        ),
    );
  }
}