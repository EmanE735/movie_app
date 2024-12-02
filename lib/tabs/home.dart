import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/service.dart';
import 'package:flutter/material.dart' hide CarouselController;

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Future<List<Movie>> nowShowingApi;
  @override
  void initState() {
    nowShowingApi = APIservice().getPopular();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: nowShowingApi,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final movies = snapshot.data!;
                  return CarouselView(
                    itemExtent: 200,
                    children: List.generate(
                      movies.length,
                      (int index) {
                        final Movie = movies[index];
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/original/${Movie.backDropPath}'))),
                            )
                          ],
                        );
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
