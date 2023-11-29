import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'food_info.dart';

class NextPage extends StatefulWidget {
  final List<String> categorysecond;
  final List<String> categoryfirst;

  NextPage(this.categorysecond, this.categoryfirst);

  @override
  _NextPageState createState() =>
      _NextPageState(categorysecond, categoryfirst);
}

class _NextPageState extends State<NextPage> {
  List<String> categorysecond = [];
  List<String> categoryfirst = [];

  _NextPageState(List<String> categorysecond, List<String> categoryfirst) {
    this.categorysecond = categorysecond;
    this.categoryfirst = categoryfirst;
    // Add any initialization logic you need for categoryfirst
  }

  Future<String> sendDataToServer() async {
    final url = Uri.parse('http://192.168.56.1:8080/api/processCategories');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "categoryfirst": categoryfirst,
          "categorysecond": categorysecond,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result;
      } else {
        print('서버 오류: ${response.statusCode}');
        return 'Error';
      }
    } catch (e) {
      print('Exception: $e');
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('식사 카테고리'),
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
                    sendDataToServer().then((result) {
                      if (result ==
                          'No match found between foodindetail and menu_name.') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("일치하는 항목이 없습니다.")),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodInfoPage(
                              selectedCategories: categoryfirst,
                              apiUrl: 'http://192.168.56.1:8080/api/processCategories',
                              categorysecond: categorysecond,
                            ),
                          ),
                        );
                      }
                    });
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