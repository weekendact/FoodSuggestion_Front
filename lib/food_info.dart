import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'store.dart';

class FoodInfoPage extends StatefulWidget {
  final List<String> selectedCategories;
  final String apiUrl;
  final List<String> categorysecond;

  FoodInfoPage({
    required this.selectedCategories,
    required this.apiUrl,
    required this.categorysecond,
  });

  @override
  _FoodInfoPageState createState() => _FoodInfoPageState();
}

class _FoodInfoPageState extends State<FoodInfoPage> {
  List<Store> storeList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse(widget.apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'categoryfirst': widget.selectedCategories,
          'categorysecond': widget.categorysecond,
        }),
      );

      print('Request: ${response.request}');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          storeList = jsonData.map((data) => Store.fromJson(data)).toList();
        });
      } else {
        // 에러 처리
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // 예외 처리
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음식 정보'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('선택된 카테고리: ${widget.selectedCategories}'),
            SizedBox(height: 20),
            Text('응답 데이터:'),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: storeList.length,
                itemBuilder: (context, index) {
                  final Store store = storeList[index];

                  return Card(
                    margin: EdgeInsets.all(16),
                    child: InkWell(
                      onTap: () async {
                        // 눌린 아이템의 이름 가져오기
                        String itemName = store.name;

                        // 선택한 카테고리와 데이터를 포함하여 다음 페이지로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(
                                  storeList: [store],
                                  selectedCategories: [itemName],
                                ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Name: ${store.name}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Distance: ${store.distance}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (store.phoneNumber != null)
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Phone Number: ${store.phoneNumber}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}