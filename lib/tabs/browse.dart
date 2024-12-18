/* -------------------------------------------------------------------------- */
/*                         Import Required Packages                            */
/* -------------------------------------------------------------------------- */
import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';
import 'package:movie_app/model/category/category.dart';
import 'package:movie_app/service/service.dart';
import 'package:movie_app/tabs/movie_list_screen.dart';

/* -------------------------------------------------------------------------- */
/*                         Browse Tab Main Widget                              */
/* -------------------------------------------------------------------------- */
class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

/* -------------------------------------------------------------------------- */
/*                         Browse Tab State                                    */
/* -------------------------------------------------------------------------- */
class _BrowseTabState extends State<BrowseTab> {
  late Future<Category> categoriesFuture;

  /* -------------------------------------------------------------------------- */
  /*                         Initialize State                                   */
  /* -------------------------------------------------------------------------- */
  @override
  void initState() {
    super.initState();
    categoriesFuture = APIservice().getCategories();
  }

  /* -------------------------------------------------------------------------- */
  /*                         Build Main Screen                                  */
  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black1,
      /* -------------------------------------------------------------------------- */
      /*                         AppBar Section                                     */
      /* -------------------------------------------------------------------------- */
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: AppTheme.black1,
          title: const Text(
            'Browse  Category',
            style: TextStyle(color: AppTheme.white2),
          ),
        ),
      ),
      /* -------------------------------------------------------------------------- */
      /*                         Categories Grid                                    */
      /* -------------------------------------------------------------------------- */
      body: FutureBuilder<Category>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          /* -------------------------------------------------------------------------- */
          /*                         Loading and Error States                          */
          /* -------------------------------------------------------------------------- */
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.genres!.isEmpty) {
            return const Center(child: Text('No categories available.'));
          }

          final categories = snapshot.data!.genres!;

          /* -------------------------------------------------------------------------- */
          /*                         Categories Grid Builder                           */
          /* -------------------------------------------------------------------------- */
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                /* -------------------------------------------------------------------------- */
                /*                         Category Card                                     */
                /* -------------------------------------------------------------------------- */
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieListScreen(
                          categoryId: category.id,
                          categoryName: category.name,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        /* -------------------------------------------------------------------------- */
                        /*                         Category Image                                   */
                        /* -------------------------------------------------------------------------- */
                        Image.asset(
                          'assets/images/${category.name}.png',
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        /* -------------------------------------------------------------------------- */
                        /*                         Overlay Effect                                   */
                        /* -------------------------------------------------------------------------- */
                        Container(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        /* -------------------------------------------------------------------------- */
                        /*                         Category Name                                   */
                        /* -------------------------------------------------------------------------- */
                        Center(
                          child: Text(
                            category.name,
                            style: const TextStyle(
                              color: AppTheme.white2,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
