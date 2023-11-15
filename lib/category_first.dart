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
  List<String> selectedCategories = [];

  void nextPage() {
    if (selectedCategories.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("적어도 한 가지 카테고리를 선택해야 합니다.")),
      );
    } else{
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NextPage(selectedCategories),
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
              value: selectedCategories.contains('한식'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('한식');
                  } else {
                    selectedCategories.remove('한식');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('중식'),
              value: selectedCategories.contains('중식'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('중식');
                  } else {
                    selectedCategories.remove('중식');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('양식'),
              value: selectedCategories.contains('양식'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('양식');
                  } else {
                    selectedCategories.remove('양식');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('일식'),
              value: selectedCategories.contains('일식'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('일식');
                  } else {
                    selectedCategories.remove('일식');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('분식'),
              value: selectedCategories.contains('분식'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('분식');
                  } else {
                    selectedCategories.remove('분식');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('아시아푸드'),
              value: selectedCategories.contains('아시아푸드'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('아시아푸드');
                  } else {
                    selectedCategories.remove('아시아푸드');
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