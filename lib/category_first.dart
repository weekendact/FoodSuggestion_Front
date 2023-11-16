// main.dart 식사
import 'package:flutter/material.dart';
import 'category_second.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategorySelectionPage(),
    );
  }
}

class CategorySelectionPage extends StatefulWidget {
  @override
  _CategorySelectionPageState createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  List<String> categoryfirst = [];

  void nextPage() {
    if (categoryfirst.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("적어도 한 가지 카테고리를 선택해야 합니다.")),
      );
    } else{
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NextPage(categotysecond),
        ),
      );
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
              title: Text('한식'),
              value: categoryfirst.contains('한식'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    categoryfirst.add('한식');
                  } else {
                    categoryfirst.remove('한식');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('중식'),
              value: categoryfirst.contains('중식'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    categoryfirst.add('중식');
                  } else {
                    categoryfirst.remove('중식');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('양식'),
              value: categoryfirst.contains('양식'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    categoryfirst.add('양식');
                  } else {
                    categoryfirst.remove('양식');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('일식'),
              value: categoryfirst.contains('일식'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    categoryfirst.add('일식');
                  } else {
                    categoryfirst.remove('일식');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('분식'),
              value: categoryfirst.contains('분식'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    categoryfirst.add('분식');
                  } else {
                    categoryfirst.remove('분식');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('아시아푸드'),
              value: categoryfirst.contains('아시아푸드'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    categoryfirst.add('아시아푸드');
                  } else {
                    categoryfirst.remove('아시아푸드');
                  }
                });
              },
            ),
            ElevatedButton(
              onPressed: nextPage,
              child: Text('다음 페이지로'),
            ),
          ],
        ),
      ),
    );
  }
} //dsa