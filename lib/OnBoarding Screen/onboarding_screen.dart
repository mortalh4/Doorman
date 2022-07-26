import 'package:doorman_app/HomePage/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'build_page.dart';

class onboardingScreen extends StatefulWidget {
  const onboardingScreen({Key? key}) : super(key: key);

  @override
  State<onboardingScreen> createState() => _onboardingScreenState();
}

class _onboardingScreenState extends State<onboardingScreen> {

  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            controller: controller,
            children: [
              buildPage(
                color: Color(0xFFFFE5DD),
                urlImage: 'assets/images/page1_image-01-01-01-01.png',
                title: 'Kapıcı Uygulamasına Hoşgeldiniz',
                subtitle:
                    'Bu uygulama sayesinde apartmanınızda oturan ailelerin alışverişlerini listeleyebilirsiniz.',
                titleColor: Color(0xFF3E4756),
              ),
              buildPage(
                color: Color(0xFF00908A),
                urlImage: 'assets/images/page2_image-01-01.png',
                title: 'Daire Oluştur',
                subtitle:
                    'Yeni kontrol etmeye başladığınız daireleri listene ekle',
                titleColor: Color(0xFF42536F),
              ),
              buildPage(
                color: Color(0xFFD6EFEE),
                urlImage: 'assets/images/page3_image-01-01.png',
                title: 'Siparişleri Kontrol Et',
                subtitle:
                    'Ödeme zamanı geldiğinde kimin ne alışveriş yaptığını rahatça kontrol edebilirsin',
                titleColor: Color(0xFF2F4858),
              ),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ?  TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)
                    ),
                    primary: Colors.white,
                    backgroundColor: Color(0xFF2F4858),
                    minimumSize: const Size.fromHeight(80)
                  ),
                    onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> homePage()));
                    },
                    child: const Text(
                      'Hadi Başlayalım',
                      style: TextStyle(fontSize: 24),
                    ))
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () => controller.jumpToPage(2),
                        child: Text("Geç",style: TextStyle(color: Color(0xFF2F4858)),)),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: Color(0xFF2F4858),
                        ),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut),
                      ),
                    ),
                    TextButton(
                        onPressed: () => controller.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut),
                        child: Text("Sonraki",style: TextStyle(color: Color(0xFF2F4858)))),
                  ],
                ),
              ),
      ),
    );
  }
}
