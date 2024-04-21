import 'package:cinema7/screens/home/EventosComponents.dart';
import 'package:cinema7/screens/home/TextComponent.dart';
import 'package:cinema7/screens/home/buildDot.dart';
import 'package:cinema7/screens/home/buscar.dart';
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
  List moviesAll = [];
  List events = [];
  //search textcontroller
  final TextEditingController searchController = TextEditingController();


  PageController pageController = PageController(initialPage: 0, viewportFraction: 0.8);


  @override
  void initState() {
    // TODO: implement initState
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
                    EventosComponents(events: events)
                  ],
                ),
              )
          )
        ],
      )
    );
  }
}
