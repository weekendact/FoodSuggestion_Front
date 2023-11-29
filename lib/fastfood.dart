import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Store {
  final String name;
  final double distance;
  final String? phoneNumber;

  Store({
    required this.name,
    required this.distance,
    this.phoneNumber,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      name: json['name_store'],
      distance: json['distance_store'].toDouble(),
      phoneNumber: json['phonenum'],
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
              onPressed: () async {
                // Build your URL with selected categories
                String url =
                    'http://192.168.56.1:8080/stores/getStoreInfoByCategories?';
                for (String category in selectedCategories) {
                  url += 'foodindetail=$category&';
                }

                // Remove the trailing '&' if there are selected categories
                if (selectedCategories.isNotEmpty) {
                  url = url.substring(0, url.length - 1);
                }

                // Fetch data from the server
                List<Store> storeList = await fetchStoreData(url);

                // Navigate to the next page with selected categories and data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyListView(storeList),
                  ),
                );
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

  Future<List<Store>> fetchStoreData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
      List<Store> storeList = jsonData.map((data) => Store.fromJson(data)).toList();
      return storeList;
    } else {
      throw Exception('Failed to load store data');
    }
  }
}

class MyListView extends StatelessWidget {
  final List<Store> storeList;

  MyListView(this.storeList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음식점 추천'),
      ),
      body: ListView.builder(
        itemCount: storeList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storeList[index].name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '거리: ${storeList[index].distance}m',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '전화번호: ${storeList[index].phoneNumber ?? "정보 없음"}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}