
//회원가입 페이지입니다~

import 'package:flutter/material.dart';

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


class SignUpData { //백으로 보낼 정보들
  String name_user = ""; //아이디
  String passwd_user = ""; //비번
  bool Allergen_ox = false; //알러지 유무
  Map<String, bool> allergens = {}; //알러지 종류
}

class SignUpPage extends StatefulWidget {
  @override
  SignUpList createState() => SignUpList();
}

class SignUpList extends State<SignUpPage> {
  bool Allergie_switchValue = false;
  bool setAllergieValue = false;
  Map<String, bool> _isCheckedMap = {};
  List<String> checkboxLabels = [ //알러지 리스트
    '소고기', '돼지고기', '닭고기',
    '갑각류', '견과류', '달걀',
    '밀', '생선', '우유',
    '조개', '콩', '메밀',
  ]; //알러지 리스트
  bool isUsernameEmpty = false;
  bool isUserpwEmpty = false;
  String outputText = "";
  SignUpData signUpData = SignUpData();

  void EmptyCheck(){ //입력 알맞게 했는지 아닌지 확인하는 함수
    if(signUpData.name_user.isEmpty){
      setState(() {
        outputText = "아이디를 입력해주세요";
      });
      return;
    }
    if(signUpData.name_user.length<4 || signUpData.name_user.length > 8){
      setState(() {
        outputText = "아이디는 4자부터 8자까지 입니다.";
      });
      return;
    }
    if(signUpData.passwd_user.isEmpty){
      setState(() {
        outputText = "비밀번호를 입력해주세요";
      });
      return;
    }
    if(signUpData.passwd_user.length<4 || signUpData.passwd_user.length > 8){
      setState(() {
        outputText = "비밀번호는 4자부터 8자까지 입니다.";
      });
      return;
    }
    if(setAllergieValue && signUpData.allergens.isEmpty){
      setState(() {
        outputText = "알레르기 종류에 체크해주세요";
      });
      return;
    }
    setState(() {
      outputText = "";
    });
  } //입력 알맞게 했는지 아닌지 확인하는 함수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: Column(
        children: [
          Row( //아이디 입력
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
                        hintText: '아이디  (최소 4자 ~ 최대 8자)',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ), //아이디 입력
          Divider(),
          Row( //비번 입력
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
                        hintText: '비밀번호  (최소 4자 ~ 최대 8자)',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ), //비번 입력
          Divider(),
          Row( //알러지 유무 체크
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
          ), //알러지 유무 체크
          Column( //알러지 종류 체크
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
          ), //알러지 종류 체크
          Divider(),
          Row( //회원가입 버튼 onPressed에 있는 print는 객체에 정보가 저장되었는지 확인용
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: ElevatedButton(
                  onPressed: () {
                    print("Username: ${signUpData.name_user}");
                    print("Password: ${signUpData.passwd_user}");
                    print("Allergen_ox: ${signUpData.Allergen_ox}");
                    print("Allergens: ${signUpData.allergens}");
                    EmptyCheck();
                  },
                  child: Text("회원가입"),
                ),
              ),
              Container( //평소는 공백이였다 입력 잘못했으면 출력됨
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  outputText,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ), //회원가입 버튼 onPressed에 있는 print는 객체에 정보가 저장되었는지 확인용
        ],
      ),
    );
  }
}
