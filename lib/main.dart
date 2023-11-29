import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:object_food_suggestion_project/signuppage.dart';
import 'package:object_food_suggestion_project/category_first.dart';
import 'package:object_food_suggestion_project/fastfood.dart';
import 'package:object_food_suggestion_project/mypage.dart';
import 'package:object_food_suggestion_project/setting.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('인후한끼'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              '/Users/isoyeon/StudioProjects/Project_sh/assets/images/인후.png',
              height: 100,
              fit: BoxFit.contain,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '아이디',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '패스워드',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text;
                String password = _passwordController.text;

                var response = await http.post(
                  Uri.parse('http://192.168.56.1:8080/login'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'name_user': email,
                    'passwd_user': password,
                  }),
                );

                if (response.statusCode == 200) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                } else {
                  print('로그인 실패.');
                }
              },
              child: Text('로그인'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
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
    MyHomePage(),
    HomePage(),
    SettingPage(),
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
          refresh(index);
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
                SizedBox(width: 1.0),
                Expanded(
                  child: SquareButton(
                    buttonText: '디저트',
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
            // LayerWidget(
            //   color: Colors.lightGreen,
            //   text: 'Layer 2 내용',
            // ),
            // LayerWidget(
            //   color: Colors.orange,
            //   text: 'Layer 3 내용',
            // ),
            // LayerWidget(
            //   color: Colors.purple,
            //   text: 'Layer 4 내용',
            // ),
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
