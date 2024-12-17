import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';
import 'package:movie_app/model/category/category.dart';
import 'package:movie_app/service/service.dart';
import 'package:movie_app/tabs/movie_list_screen.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  late Future<Category> categoriesFuture;
  @override
  void initState() {
    super.initState();
    categoriesFuture = APIservice().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black1,
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
      body: FutureBuilder<Category>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.genres!.isEmpty) {
            return const Center(child: Text('No categories available.'));
          } else {
            final categories = snapshot.data!.genres!;
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
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the MovieListScreen when a category is clicked
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
                          Image.asset(
                            'assets/images/${category.name}.png',
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
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
          }
        },
      ),
    );
  }
}
