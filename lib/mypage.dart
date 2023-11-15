import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserData()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {
        '/password_change': (context) => PasswordChangePage(),
        '/allergies_edit': (context) => AllergiesEditPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MyInfoPage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}



class MyInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text("아이디\n\n${userData.name_user}"),
            ),
            ListTile(
              title: Text("비밀번호  ${userData.maskedPassword}"),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("알러지 정보"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/allergies_edit');
                  },
                  child: Text("수정"),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Expanded(
              child: ListView(
                children: userData.allergy_info.split(', ').map((allergy) {
                  return ListTile(
                    title: Text(allergy),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllergyItem extends StatelessWidget {
  final String allergy;

  AllergyItem({required this.allergy});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(allergy),
    );
  }
}

class PasswordChangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("비밀번호 변경"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "새로운 비밀번호"),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // 비밀번호 변경 로직을 구현할 수 있습니다.
              },
              child: Text("변경하기"),
            ),
          ],
        ),
      ),
    );
  }
}

class AllergiesEditPage extends StatefulWidget {
  @override
  _AllergiesEditPageState createState() => _AllergiesEditPageState();
}

class _AllergiesEditPageState extends State<AllergiesEditPage> {
  final TextEditingController allergiesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserData userData = Provider.of<UserData>(context, listen: false);
    allergiesController.text = userData.allergy_info;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("알러지 정보 수정"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: allergiesController,
              decoration: InputDecoration(labelText: "알러지 정보"),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                UserData userData = Provider.of<UserData>(context, listen: false);
                userData.allergy_info = allergiesController.text;
                Navigator.of(context).pop();
              },
              child: Text("저장"),
            ),
          ],
        ),
      ),
    );
  }
}

class UserData with ChangeNotifier {
  String name_user = "johndoe123";
  String passwd_user= "supersec"; // 실제 비밀번호
  String allergy_info = "Peanuts, Shellfish";

  // 비밀번호를 별로 반환
  String get maskedPassword {
    if (passwd_user.length >= 0) {
      return '*' * passwd_user.length + passwd_user.substring(passwd_user.length);
    } else {
      return '*' * passwd_user.length;
    }
  }

  void changePassword(String newPassword) {
    passwd_user = newPassword;
    notifyListeners();
  }
}
