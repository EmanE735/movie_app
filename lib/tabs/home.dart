import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/service.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

int current = 0;

class _HomeTabState extends State<HomeTab> {
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> upComing;
  late Future<List<Movie>> topRated;
  @override
  void initState() {
    popularMovies = APIservice().getPopular();
    upComing = APIservice().getUpComing();
    topRated = APIservice().getTopRated();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final movies = snapshot.data!;
                  return Column(children: [
                    Container(
                      height: height * 0.3,
                      color: AppTheme.black1,
                      width: double.infinity,
                      child: Stack(children: [
                        CarouselView(
                          itemSnapping: true,
                          elevation: 4,
                          shape: RoundedRectangleBorder(),
                          itemExtent: MediaQuery.of(context).size.width,
                          children: List.generate(
                            movies.length,
                            (int index) {
                              final Movie = movies[index];
                              return Stack(children: [
                                Container(
                                  // height: height * .2,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://image.tmdb.org/t/p/original/${Movie.backDropPath},"),
                                          fit: BoxFit.cover)),
                                ),
                                // Image.network(
                                //   "https://image.tmdb.org/t/p/original/${Movie.backDropPath},",
                                //   height: height * .2,
                                //   fit: BoxFit.cover,
                                // ),
                                // Positioned(
                                //   bottom: 20,
                                //   left: 10,
                                //   child: Container(
                                //     height: height * .2,
                                //     width: width * .3,
                                //     decoration: BoxDecoration(
                                //         image: DecorationImage(
                                //             image: NetworkImage(
                                //                 "https://image.tmdb.org/t/p/original/${Movie.backDropPath},"),
                                //             fit: BoxFit.cover)),
                                //   ),
                                // ),

                                // Positioned(
                                //   bottom: height * .05,
                                //   left: width * .4,
                                //   child: Text(
                                //     "${Movie.title}",
                                //     style: TextStyle(color: AppTheme.black1),
                                //   ),
                                // ),
                              ]);
                            },
                          ),
                        ),
                      ]),
                    ),
                  ]);
                }),
            SizedBox(
              height: 10,
            ),
            Container(
              color: AppTheme.black2,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Releases",
                    style: TextStyle(color: AppTheme.white1, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: upComing,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final movies = snapshot.data!;
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: CarouselView(
                            padding: EdgeInsets.only(right: 15),
                            itemSnapping: true,
                            elevation: 4,
                            shape: RoundedRectangleBorder(),
                            itemExtent: MediaQuery.of(context).size.width * .3,
                            children: List.generate(
                              movies.length,
                              (int index) {
                                final Movie = movies[index];
                                return Container(
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/original/${Movie.backDropPath}',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: AppTheme.black2,
              padding: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recomended",
                    style: TextStyle(color: AppTheme.white1, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: topRated,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final movies = snapshot.data!;
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: CarouselView(
                            padding: EdgeInsets.only(right: 15),
                            itemSnapping: true,
                            elevation: 4,
                            shape: RoundedRectangleBorder(),
                            itemExtent: MediaQuery.of(context).size.width * .3,
                            children: List.generate(
                              movies.length,
                              (int index) {
                                final Movie = movies[index];
                                return Container(
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/original/${Movie.backDropPath}',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
