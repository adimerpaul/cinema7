import 'package:cinema7/screens/home/EventosComponents.dart';
import 'package:cinema7/screens/home/TextComponent.dart';
import 'package:cinema7/screens/home/buildDot.dart';
import 'package:cinema7/screens/home/buscar.dart';
import 'package:cinema7/screens/home/header.dart';
import 'package:cinema7/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

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
  List moviesAll = [];
  List events = [];
  List proximos = [];
  //search textcontroller
  final TextEditingController searchController = TextEditingController();


  PageController pageController = PageController(initialPage: 0, viewportFraction: 0.8);


  @override
  void initState() {
    super.initState();
    moviesGet();
  }
  moviesGet() async {
    var response = await MovieService().movies();
    setState(() {
      movies = response;
      moviesAll = response;
    });
    response = await MovieService().events();
    setState(() {
      events = response;
    });
    response = await MovieService().proximos();
    setState(() {
      proximos = response;
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
                    Buscar(
                      searchController: searchController,
                      onChanged: (text) { // Cambiado a (text)
                        setState(() {
                          if (text.isNotEmpty) {
                            movies = moviesAll.where((movie) => movie['nombre'].toLowerCase().contains(text.toLowerCase())).toList();
                          } else {
                            movies = moviesAll;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextComponent(texto: 'Peliculas'),
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
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(movies.length, (index) => BuildDot(
                            currentPage: currentPage,
                            index: index,
                          )
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextComponent(texto: 'Eventos'),
                    const SizedBox(height: 20),
                    EventosComponents(events: events),
                    const SizedBox(height: 20),
                    TextComponent(texto: 'Proximamente'),
                    const SizedBox(height: 20),
                    EventosComponents(events: proximos),
                  ],
                ),
              )
          )
        ],
      ),
      // floatingActionButton: Container(
      //   height: 60.0,
      //   width: 60.0,
      //   child: FittedBox(
      //     child: FloatingActionButton(
      //       backgroundColor: kPrimaryColor,
      //       onPressed: () {},
      //       child: Icon(
      //         // Icono de pelicula
      //         Icons.movie_filter_sharp,
      //         color: Colors.white,
      //       ),
      //       shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(30.0)),
      //       ),
      //       // elevation: 5.0,
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        backgroundColor: kPrimaryColor,
        color: kTitleTextColor,
        // curve: Curves.easeInOut,
        // curveSize: 0,
        height: 60,
        items: [
          TabItem(title: 'Inicio', icon: Icons.home_outlined, activeIcon: Icons.home),
          TabItem(title: 'Peliculas', icon: Icons.movie_creation_outlined, activeIcon: Icons.movie_creation),
          TabItem(title: 'Eventos', icon: Icons.event_outlined, activeIcon: Icons.event),
          TabItem(title: 'Proximos', icon: Icons.calendar_today_outlined, activeIcon: Icons.calendar_today),
        ],
        initialActiveIndex: 0,
        onTap: (int i) => print('click index=$i'),
      ),
    );
  }
  // Widget _buildNavItem(IconData icon, String label) {
  //   return Column(
  //     // mainAxisSize: MainAxisSize.min,
  //     children: [
  //       IconButton(
  //         icon: Icon(icon),
  //         color: kTitleTextColor,
  //         onPressed: () {},
  //         padding: EdgeInsets.zero,
  //       ),
  //       Text(
  //         label,
  //         style: TextStyle(color: kTitleTextColor),
  //       ),
  //     ],
  //   );
  // }
}
