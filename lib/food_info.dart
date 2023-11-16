import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FoodInfoPage(selectedCategories, url);
    );
  }
}

class FoodInfoPage extends StatefulWidget {
  final List<String> selectedCategories;
  final String url;

  FoodInfoPage(this.selectedCategories, this.url);

  @override
  _FoodInfoPageState createState() => _FoodInfoPageState();
}

class _FoodInfoPageState extends State<FoodInfoPage> {
  PageController pageController = PageController(initialPage: 1);
  List<Map<String, dynamic>> imageAndText = [];
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      if (pageController.page == 0) {
        pageController.jumpToPage(imageAndText.length - 2);
      } else if (pageController.page == imageAndText.length - 1) {
        pageController.jumpToPage(1);
      } else {
        currentPage = pageController.page?.round() ?? 1;
      }
    });

    imageAndText = [
      {
        "imagePath": "assets/images/치킨.jpeg",
        "text": "치킨",
        "width": 180.0,
        "height": 180.0,
      },
      {
        "imagePath": "assets/images/닭갈비.jpeg",
        "text": "닭갈비\n- 탄수화물 : 23.1g\n- 단백질 : 45.5g\n- 지방 : 31.6g\n- 당류 : 8.5g\n- 나트륨 : 1016.94mg\n- 콜레스테롤 : 217.67mg\n- 포화지방산 : 11.3g\n- 트랜스지방 : 0.3g",
        "width": 200.0,
        "height": 200.0,
      },
      {
        "imagePath": "assets/images/백숙.jpeg",
        "text": "백숙",
        "width": 150.0,
        "height": 150.0,
      },
      {
        "imagePath": "assets/images/치킨.jpeg",
        "text": "치킨",
        "width": 180.0,
        "height": 180.0,
      },
      {
        "imagePath": "assets/images/닭갈비.jpeg",
        "text": "닭갈비\n- 탄수화물 : 23.1g\n- 단백질 : 45.5g\n- 지방 : 31.6g\n- 당류 : 8.5g\n- 나트륨 : 1016.94mg\n- 콜레스테롤 : 217.67mg\n- 포화지방산 : 11.3g\n- 트랜스지방 : 0.3g",
        "width": 200.0,
        "height": 200.0,
      },
    ];
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void goToFirstImage() {
    pageController.jumpToPage(1);
  }

  void goToPreviousImage() {
    if (currentPage > 1) {
      pageController.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("음식 정보"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imageAndText[index]["imagePath"],
                      width: imageAndText[index]["width"],
                      height: imageAndText[index]["height"],
                    ),
                    SizedBox(height: 16),
                    Text(
                      imageAndText[index]["text"],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
              itemCount: imageAndText.length,
            ),
          ),
          SizedBox(height: 16),
          if (currentPage == imageAndText.length - 2)
            LastPageButton(goToPreviousImage),
          if (currentPage == imageAndText.length - 1)
            LastPageButton(goToFirstImage),
        ],
      ),
    );
  }
}

class LastPageButton extends StatelessWidget {
  final VoidCallback onPressed;

  LastPageButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          child: Text("처음 사진 화면으로 돌아가기"),
        ),
      ],
    );
  }
}
