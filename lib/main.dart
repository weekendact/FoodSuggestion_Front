import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:object_food_suggestion_project/Sign_Up_Page.dart';
import 'package:object_food_suggestion_project/home.dart'; // http 패키지 import

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
                labelText: '비밀번호',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text;
                String password = _passwordController.text;

                // 로그인 요청을 보내고 응답 처리
                var response = await http.post(
                  Uri.parse('http://192.168.56.1:8080/login'), // 로그인 엔드포인트 URL
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'name_user': email,
                    'passwd_user': password,
                  }),
                );

                if (response.statusCode == 200) {
                  // 로그인 성공
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
                else {
                  // 로그인 실패
                  print('로그인 실패.');
                }
              },
              child: Text('로그인'),
            ),
            SizedBox(height: 10),

        ElevatedButton(
          onPressed: () {
            // 회원가입 버튼 클릭 시 회원가입 화면으로 이동
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
