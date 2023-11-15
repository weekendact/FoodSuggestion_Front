// main.dart 패스트푸드
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCategorySelectionPage(),
    );
  }
}

class MyCategorySelectionPage extends StatefulWidget {
  @override
  _MyCategorySelectionPageState createState() => _MyCategorySelectionPageState();
}

class _MyCategorySelectionPageState extends State<MyCategorySelectionPage> {
  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('패스트푸드 카테고리'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text('치킨'),
              value: selectedCategories.contains('치킨'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('치킨');
                  } else {
                    selectedCategories.remove('치킨');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('피자'),
              value: selectedCategories.contains('피자'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('피자');
                  } else {
                    selectedCategories.remove('피자');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('버거/샌드위치'),
              value: selectedCategories.contains('버거/샌드위치'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('버거/샌드위치');
                  } else {
                    selectedCategories.remove('버거/샌드위치');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('컵밥'),
              value: selectedCategories.contains('컵밥'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('컵밥');
                  } else {
                    selectedCategories.remove('컵밥');
                  }
                });
              },
            ),
            ElevatedButton(
              onPressed: (){},
              child: Text('다음 페이지로'),
            ),
          ],
        ),
      ),
    );
  }
}
