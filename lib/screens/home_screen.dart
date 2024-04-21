import 'package:cinema7/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Multicines PLAZA ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage('assets/logo.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      )
    );
  }
}
