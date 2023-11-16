import 'package:flutter/material.dart';
import 'package:object_food_suggestion_project/setting.dart';
import 'category_first.dart';
import 'fastfood.dart';
import 'mypage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserData()),
      ],
      child: MaterialApp(
        home: MyApp(),
        routes: {
          '/password_change': (context) => PasswordChangePage(),
          '/allergies_edit': (context) => AllergiesEditPage(),
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    MyInfoPage(),
    HomePage(),
    SettingPage()
  ];

  void refresh(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '내 페이지',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
        onTap: (index) {
          print("탭한 인덱스 $index");
          refresh(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SquareButton(
                    buttonText: '카테고리',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategorySelectionPage()),
                      );
                    },
                  ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: SquareButton(
                    buttonText: '패스트푸드',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyCategorySelectionPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
            LayerWidget(
              color: Colors.lightBlue,
              text: 'Layer 1 내용',
            ),
            LayerWidget(
              color: Colors.lightGreen,
              text: 'Layer 2 내용',
            ),
            LayerWidget(
              color: Colors.orange,
              text: 'Layer 3 내용',
            ),
            LayerWidget(
              color: Colors.purple,
              text: 'Layer 4 내용',
            ),
          ],
        ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  SquareButton({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonSize = (screenWidth - 48.0) / 3;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: BorderSide(color: Colors.black),
        minimumSize: Size(buttonSize, buttonSize),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class LayerWidget extends StatelessWidget {
  final Color color;
  final String text;

  LayerWidget({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: color,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
