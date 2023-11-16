import 'package:flutter/material.dart';

import 'food_info.dart';

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
  _MyCategorySelectionPageState createState() =>
      _MyCategorySelectionPageState();
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
                updateSelectedCategories('치킨', newValue!);
              },
            ),
            CheckboxListTile(
              title: Text('피자'),
              value: selectedCategories.contains('피자'),
              onChanged: (newValue) {
                updateSelectedCategories('피자', newValue!);
              },
            ),
            CheckboxListTile(
              title: Text('햄버거'),
              value: selectedCategories.contains('햄버거'),
              onChanged: (newValue) {
                updateSelectedCategories('햄버거', newValue!);
              },
            ),
            CheckboxListTile(
              title: Text('샌드위치'),
              value: selectedCategories.contains('샌드위치'),
              onChanged: (newValue) {
                updateSelectedCategories('샌드위치', newValue!);
              },
            ),
            CheckboxListTile(
              title: Text('컵밥'),
              value: selectedCategories.contains('컵밥'),
              onChanged: (newValue) {
                updateSelectedCategories('컵밥', newValue!);
              },
            ),
            ElevatedButton(
              onPressed: () {
                navigateToNextPage();
              },
              child: Text('다음 페이지로'),
            ),
          ],
        ),
      ),
    );
  }

  void updateSelectedCategories(String category, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedCategories.add(category);
      } else {
        selectedCategories.remove(category);
      }
    });
  }

  void navigateToNextPage() async {
    // Build your URL with selected categories
    String url = 'http://192.168.56.1:8080/stores/getStoreInfoByCategories?';
    for (String category in selectedCategories) {
      url += 'foodindetail=$category&';
    }

    // Remove the trailing '&' if there are selected categories
    if (selectedCategories.isNotEmpty) {
      url = url.substring(0, url.length - 1);
    }

    // Navigate to the next page with selected categories
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodInfoPage(selectedCategories, url),
      ),
    );
  }

}
