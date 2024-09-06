import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaperflux/screens/about_us.dart';
import 'package:wallpaperflux/screens/download_screen.dart';
import 'package:wallpaperflux/screens/privacy_policy.dart';
import 'package:wallpaperflux/screens/search_screen.dart';
import 'package:wallpaperflux/widgets/custom_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../admobHelper/admobHelper.dart';
import '../data/data.dart';
import '../model/categories_model.dart';
import '../model/wallpaper_model.dart';
import '../widgets/brand_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchQuery = TextEditingController();
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];
  var currentYear = DateTime.now().year.toString();
  bool isLoading = true;

  Future<void> getTrendingWallpaper() async {
    setState(() {
      isLoading = true;
    });
    var response = await http.get(
      Uri.parse("https://api.pexels.com/v1/curated?per_page=100&page=1"),
      headers: {"Authorization": apiKey},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<WallpaperModel> fetchedWallpapers = [];
      // for android
      jsonData["photos"].forEach((element) {
        WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
        fetchedWallpapers.add(wallpaperModel);
      });
      setState(() {
        wallpapers = fetchedWallpapers;

        isLoading = false;
      });
    } else {
      if (kDebugMode) {
        print('Failed to load wallpapers');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getTrendingWallpaper();
    categories = getCategories();

  }

  @override
  void dispose() {
    super.dispose();
    searchQuery.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(currentYear),
        elevation: 4.0,
        bottomOpacity: 5.0,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton<String>(
            color: Colors.white.withOpacity(0.3),
            splashRadius: 2.0,
            onSelected: (value) {
              if (value == 'aboutUs') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutUsScreen()));
              } else if (value == 'privacyPolicy') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen()));
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'aboutUs',
                child: CustomText(
                  text: 'About Us',
                  fontSize: 15,
                ),
              ),
              const PopupMenuItem<String>(
                value: 'privacyPolicy',
                child: CustomText(
                  text: 'Privacy Policy',
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ))
          : Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 26, right: 26),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15,
                        spreadRadius: 2.0)
                  ],
                  color: const Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchQuery,
                        decoration: const InputDecoration(
                          hintText: 'Search Wallpaper',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          String query = searchQuery.text.toString();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen(
                                        searchQuery: query,
                                      )));
                          searchQuery.clear();
                        },
                        child: const Icon(Icons.search)),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesListTile(
                      title: categories[index].categoriesName,
                      imgUrl: categories[index].imgUrl,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen(
                                      searchQuery:
                                          categories[index].categoriesName,
                                    )));
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: wallpapers.length,
                  itemBuilder: (context, index) {
                      int wallpaperIndex = index - (index ~/ 6); // Adjust index for wallpapers
                      return GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DownloadWallpaper(
                                      imgUrl: wallpapers[wallpaperIndex].src!.portrait!,
                                    )));
                          },
                          child: Hero(
                            tag: wallpapers[wallpaperIndex].src!.portrait!,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  wallpapers[wallpaperIndex].src!.portrait!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),

            ],
          ),
    );
  }
}

class CategoriesListTile extends StatelessWidget {
  final String title;
  final String imgUrl;
  final VoidCallback onTap;

  const CategoriesListTile(
      {super.key,
      required this.title,
      required this.imgUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imgUrl,
                height: 60,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black26,
              ),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
