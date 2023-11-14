// category_second.dart
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  final List<String> selectedCategories;

  NextPage(this.selectedCategories);

  @override
  _NextPageState createState() => _NextPageState(selectedCategories);

}

class _NextPageState extends State<NextPage> {
  List<String> selectedCategories;

  _NextPageState(this.selectedCategories);

  @override
  Widget build(BuildContext context) {
    String categoryText = selectedCategories.join(',');
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryText'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text('밥'),
              value: selectedCategories.contains('밥'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue==true) {
                    selectedCategories.add('밥');
                  } else {
                    selectedCategories.remove('밥');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('면'),
              value: selectedCategories.contains('면'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue==true) {
                    selectedCategories.add('면');
                  } else {
                    selectedCategories.remove('면');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('빵'),
              value: selectedCategories.contains('빵'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('빵');
                  } else {
                    selectedCategories.remove('빵');
                  }
                });
              },
            ),

            CheckboxListTile(
              title: Text('떡'),
              value: selectedCategories.contains('떡'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('떡');
                  } else {
                    selectedCategories.remove('떡');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('고기'),
              value: selectedCategories.contains('고기'),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == true) {
                    selectedCategories.add('고기');
                  } else {
                    selectedCategories.remove('고기');
                  }
                });
              },
            ),
            Row( // "이전 페이지로" 버튼과 "다음 페이지로" 버튼을 가로로 나란하게 배치
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // 이전 페이지로 돌아가기
                  },
                  child: Text('이전 페이지로'),
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text('다음 페이지로'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} //dweq