import 'package:cinema7/screens/home/header.dart';
import 'package:cinema7/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../services/MovieService.dart';
import '../../../globals.dart' as globals;
import 'movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  //array movies
  List movies = [];
  PageController pageController = PageController(initialPage: 0, viewportFraction: 0.8);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesGet();
  }
  moviesGet() async {
    var response = await MovieService().movies();
    print(response);
    setState(() {
      movies = response;
    });
    // movies.forEach((element) {
    //   print(globals.API_BACK + '../../../imagen/' + element['imagen']);
    // });
  }
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
                    header(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: kSearchbarColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          style: TextStyle(color: kTitleTextColor),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Buscar',
                            hintStyle: TextStyle(color: kTitleTextColor),
                            prefixIcon: Icon(Icons.search, color: kTitleTextColor)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Peliculas',
                            style: TextStyle(
                              color: kTitleTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Ver todo',
                            style: TextStyle(
                              color: kButtonColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 250,
                      child: PageView.builder(
                        controller: pageController,
                        onPageChanged: (int page){
                          setState(() {
                            currentPage = page;
                          });
                        },
                        itemCount: movies.length,
                        itemBuilder: (context, index){
                          return MovieCard(
                            movie: movies[index],
                            currentPage: currentPage,
                            index: index,
                          );
                        },
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
