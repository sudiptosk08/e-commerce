import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/screens/splash_screen/intro_page/intro_page_1.dart';
import 'package:ecommerce_app/features/view/screens/splash_screen/intro_page/intro_page_2.dart';
import 'package:ecommerce_app/features/view/screens/splash_screen/intro_page/intro_page_3.dart';
import 'package:ecommerce_app/navigation_bar.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (value) {
            setState(() {
              onLastPage = (value == 2);
            });
          },
          children: const [
             IntroPage1(),
             IntroPage2(),
             IntroPage3(),
          ],
        ),
        Container(
            alignment: const Alignment(0, 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                      spacing: 8.0,
                      radius: 8.0,
                      dotWidth: 20.0,
                      dotHeight: 12.0,
                      dotColor: KColor.textgrey.withOpacity(0.4),
                      activeDotColor: KColor.primary),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _controller.jumpToPage(2);
                        },
                        child: Text(
                          "skip",
                          style: TextStyles.bodyText1
                              .copyWith(color: KColor.textgrey, fontSize: 16),
                        ),
                      ),
                      onLastPage
                          ? GestureDetector(
                              onTap: () {
                                NavigationService.navigateTo(SlideRightRoute(
                                    page: const NavigationBarScreen(
                                  page: "0",
                                )));
                              },
                              child: Container(
                                width: 70,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: KColor.primary,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: KColor.primary.withOpacity(0.1),
                                        offset: Offset(2.0, 4.0),
                                        blurRadius: 6.0,
                                        spreadRadius: 5
                                        //blurStyle: BlurStyle.outer
                                        ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.arrow_forward_outlined,
                                  color: KColor.white,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _controller.nextPage(
                                    duration: Duration(microseconds: 50),
                                    curve: Curves.easeIn);
                              },
                              child: Container(
                                width: 70,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: KColor.primary,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: KColor.primary.withOpacity(0.1),
                                        offset: Offset(2.0, 4.0),
                                        blurRadius: 6.0,
                                        spreadRadius: 5
                                        //blurStyle: BlurStyle.outer
                                        ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.arrow_forward_outlined,
                                  color: KColor.white,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            )),
      ]),
    );
  }
}
