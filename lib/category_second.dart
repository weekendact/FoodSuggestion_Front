// category_second.dart
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  final List<String> categoryfirst;

  NextPage(this.categoryfirst);

  @override
  _NextPageState createState() => _NextPageState(categoryfirst);

}

class _NextPageState extends State<NextPage> {
  List<String> categorysecond=[];

  // 이제 생성자를 위젯에서 가져오도록 수정
  _NextPageState(List<String> categoryfirst) {
    // categoryfirst를 categorysecond로 복사
    categorysecond.addAll(categoryfirst);
  }

  @override
  Widget build(BuildContext context) {
    String categoryText = categorysecond.join(',');
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
                  if (newValue==true) {
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
                  if (newValue==true) {
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