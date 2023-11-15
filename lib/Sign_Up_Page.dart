import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(),
    );
  }
}

class SignUpData {
  String name_user = "";
  String passwd_user = "";
  bool Allergen_ox = false;
  Map<String, bool> allergens = {};
}

class SignUpPage extends StatefulWidget {
  @override
  SignUpList createState() => SignUpList();
}

class SignUpList extends State<SignUpPage> {
  bool Allergie_switchValue = false;
  bool setAllergieValue = false;
  Map<String, bool> _isCheckedMap = {};
  List<String> checkboxLabels = [
    '소고기', '돼지고기', '닭고기',
    '갑각류', '견과류', '달걀',
    '밀', '생선', '우유',
    '조개', '콩', '메밀',
  ];
  bool isUsernameEmpty = false;
  bool isUserpwEmpty = false;
  String outputText = "";
  SignUpData signUpData = SignUpData();

  Future<void> signUp() async {
    Map<String, dynamic> userData = {
      "name_user": signUpData.name_user,
      "passwd_user": signUpData.passwd_user,
      "allergy_user": signUpData.Allergen_ox ? 1 : 0,
      "allergies": signUpData.allergens.keys.toList(),
    };

    var response = await http.post(
      Uri.parse('http://192.168.56.1:8080/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      print('회원가입 성공');
    } else {
      print('회원가입 실패');
    }
  }

  void EmptyCheck() {
    if (signUpData.name_user.isEmpty) {
      setState(() {
        outputText = "아이디를 입력해주세요";
      });
      return;
    }
    if (signUpData.name_user.length < 4 || signUpData.name_user.length > 16) {
      setState(() {
        outputText = "아이디는 4자부터 16자까지 입니다.";
      });
      return;
    }
    if (signUpData.passwd_user.isEmpty) {
      setState(() {
        outputText = "비밀번호를 입력해주세요";
      });
      return;
    }
    if (signUpData.passwd_user.length < 4 || signUpData.passwd_user.length > 16) {
      setState(() {
        outputText = "비밀번호는 4자부터 16자까지 입니다.";
      });
      return;
    }
    if (setAllergieValue && signUpData.allergens.isEmpty) {
      setState(() {
        outputText = "알레르기 종류에 체크해주세요";
      });
      return;
    }
    setState(() {
      outputText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text("아이디"),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: TextField(
                      onChanged: (value) {
                        signUpData.name_user = value;
                        isUsernameEmpty = signUpData.name_user.isEmpty;
                      },
                      decoration: InputDecoration(
                        hintText: '아이디  (최소 4자 ~ 최대 12자)',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text("비밀번호"),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: TextField(
                      onChanged: (value) {
                        signUpData.passwd_user = value;
                      },
                      decoration: InputDecoration(
                        hintText: '비밀번호  (최소 4자 ~ 최대 16자)',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text("알러지 유무"),
              ),
              Switch(
                value: Allergie_switchValue,
                onChanged: (value) {
                  setState(() {
                    Allergie_switchValue = value;
                    setAllergieValue = value;
                    signUpData.Allergen_ox = value;
                    if (!setAllergieValue) {
                      _isCheckedMap.clear();
                      signUpData.allergens = _isCheckedMap;
                    }
                  });
                },
              ),
            ],
          ),
          Column(
            children: [
              for (int i = 0; i < checkboxLabels.length; i += 3)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int j = i; j < i + 3 && j < checkboxLabels.length; j++)
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              checkboxLabels[j],
                              style: TextStyle(
                                color: Allergie_switchValue ? Colors.black : Colors.grey,
                              ),
                            ),
                            width: 65,
                          ),
                          Checkbox(
                            value: _isCheckedMap[checkboxLabels[j]] ?? false,
                            onChanged: setAllergieValue == true
                                ? (value) {
                              setState(() {
                                _isCheckedMap[checkboxLabels[j]] = value!;
                                signUpData.allergens = _isCheckedMap;
                              });
                            }
                                : null,
                          ),
                        ],
                      ),
                  ],
                ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: ElevatedButton(
                  onPressed: () {
                    signUp();
                    EmptyCheck();
                  },
                  child: Text("회원가입"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  outputText,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
