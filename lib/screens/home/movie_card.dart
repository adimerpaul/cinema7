import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../globals.dart' as globals;
class MovieCard extends StatefulWidget {
  final movie;
  int currentPage;
  int index;
  MovieCard({
    super.key,
    required this.movie,
    required this.currentPage,
    required this.index,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  //imagen cover
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        globals.API_BACK + '../../../imagen/' + widget.movie['imagen'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black87,
                          Colors.black45,
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.movie['nombre'],
                          style: TextStyle(
                            color: kTitleTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.movie['duracion'].toString() + ' min',
                          style: TextStyle(
                            color: kTitleTextColor,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.movie['formato'],
                              style: TextStyle(
                                color: kTitleTextColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              widget.movie['cantidad'].toString() + ' entradas',
                              style: TextStyle(
                                color: kTitleTextColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 20),
          // Text(
          //   widget.movie['nombre'],
          //   style: TextStyle(
          //     color: widget.currentPage == widget.index
          //         ? kTitleTextColor
          //         : kTitleTextColor.withOpacity(0.5),
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }
}
