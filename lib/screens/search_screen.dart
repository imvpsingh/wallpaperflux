import 'dart:convert';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpaperflux/widgets/custom_text.dart';
import '../admobHelper/admobHelper.dart';
import '../data/data.dart';
import '../model/wallpaper_model.dart';
import 'download_screen.dart';

class SearchScreen extends StatefulWidget {
     final String searchQuery;

    const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<WallpaperModel> wallpapers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getSearchedWallpapers();
    AdmobHelper.initialization();

  }

  Future<void> getSearchedWallpapers() async {
    setState(() {
      isLoading = true;
    });

    var response = await http.get(
      Uri.parse(
          "https://api.pexels.com/v1/search?query=${widget.searchQuery}&per_page=100&page=1"),
      headers: {"Authorization": apiKey},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<WallpaperModel> fetchedWallpapers = [];
      jsonData["photos"].forEach((element) {
        WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
        fetchedWallpapers.add(wallpaperModel);
      });
      setState(() {
        wallpapers = fetchedWallpapers;
        isLoading = false;
      });
    } else {
      print('Failed to load wallpapers');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.searchQuery,
          fontSize: 20,
          shadow: const [Shadow(color: Colors.white54)],
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        elevation: 4.0,
        bottomOpacity: 5.0,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue),))
          : Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 12 , vertical: 10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: wallpapers.length,
                      itemBuilder: (context, index) {
                        return GridTile(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DownloadWallpaper(imgUrl:  wallpapers[index].src!.portrait!,
                                          ),
                                  ));
                            },
                            child: Hero(
                              tag:  wallpapers[index].src!.portrait!,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    wallpapers[index].src!.portrait!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ),
              ),
              SizedBox(
                height: 80,
                // color: Colors.grey,
                child: AdWidget(ad: AdmobHelper.createBannerAd()..load()), // Load the banner ad
              )
            ],
          ),
    );
  }
}
