import 'package:flutter/material.dart';
import 'package:project_algo_trade/Auth/login_screen.dart';
import 'package:project_algo_trade/Auth/register_screen.dart';

import 'onboard_contents.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: currentIndex == index ? 14 : 8,
      width: currentIndex == index ? 14 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? const Color.fromRGBO(255, 255, 255, 1)
            : const Color.fromRGBO(68, 89, 142, 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(26, 39, 68, 1),
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Stack(
                      children: [
                        Positioned(
                            top: 50,
                            left: 45,
                            child: ClipOval(
                              child: Container(
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(50, 72, 122, 1),
                                    Color.fromRGBO(42, 62, 106, 0),
                                  ],
                                )),
                                child: Center(
                                  child: Image.asset(
                                    contents[i].image,
                                    height: 300,
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        Positioned(
                          top: 385,
                          width: 50,
                          left: 23,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              contents.length,
                              (index) => buildDot(index, context),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 430,
                          width: 400,
                          left: 20,
                          height: 50,
                          child: Text(
                            contents[i].title,
                            style: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 490,
                          width: 369,
                          left: 20,
                          height: 60,
                          child: Text(
                            contents[i].description,
                            style: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  top: 550,
                  right: 18,
                  left: 18,
                  child: Container(
                    height: 59,
                    width: 369,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(112, 181, 105, 1),
                    ),
                    child: TextButton(
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 620,
                  right: 18,
                  left: 18,
                  child: Container(
                    height: 53,
                    width: 369,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(112, 181, 105, 1),
                    ),
                    child: TextButton(
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
