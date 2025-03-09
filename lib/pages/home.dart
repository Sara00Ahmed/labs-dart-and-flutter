import 'package:flutter/material.dart';
import 'package:my_app/pages/auth.dart';
import 'package:my_app/pages/navigation_item.dart';
import 'package:my_app/pages/search.dart';
import 'package:my_app/pages/settings.dart';
import 'package:my_app/pages/movielist.dart';
import 'package:my_app/resoursces/color_manager.dart';
import 'package:my_app/resoursces/images_manager.dart';
import 'package:my_app/resoursces/text_styles_manager.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  String s = 'FilmKu';
  bool isBookmarked = false;
  double _iconSize = 30;
  double _borderSize = 2.0;
  double _glowBlur = 20.0;

  late TabController _tabController;
  int _selectedIndex = 0;

  List<NavigationItem> items = [
    NavigationItem(label: 'Home', icon: Icons.home),
    NavigationItem(label: 'Profile', icon: Icons.person),
    NavigationItem(label: 'Trending', icon: Icons.trending_up),
    NavigationItem(label: 'Favorites', icon: Icons.bookmark),
    NavigationItem(label: 'More', icon: Icons.more_horiz),
  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 56,
        backgroundColor: ColorManager.tealColor,
        title: Text('FilmKu', style: TextStyles.appBarTitle),
        titleSpacing: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AuthScreen()),
            );
          },
          icon: Icon(Icons.login_sharp, color: ColorManager.whiteColor, size: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            icon: Icon(Icons.settings, color: ColorManager.whiteColor, size: 30),
            splashColor: ColorManager.darkColor,
            splashRadius: 20.0,
            highlightColor: ColorManager.darkColor,
          ),
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: badges.Badge(
              badgeContent: Text('4', style: TextStyle(color:ColorManager.whiteColor),),
              child: Icon(Icons.notifications, size: 30),
            ),
            splashColor: ColorManager.darkColor,
            splashRadius: 20.0,
            highlightColor: ColorManager.darkColor,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            icon: Icon(Icons.search, color: ColorManager.whiteColor, size: 30),
            splashColor: ColorManager.darkColor,
            splashRadius: 20.0,
            highlightColor: ColorManager.darkColor,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    ImagesManager.cover,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MovieListScreen()),
                        );
                      },
                      icon: Icon(Icons.arrow_back, color: ColorManager.whiteColor, size: 28),
                      splashColor: ColorManager.darkColor,
                      splashRadius: 20.0,
                      highlightColor: ColorManager.darkColor,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu, color: ColorManager.whiteColor, size: 28),
                      splashColor: ColorManager.darkColor,
                      splashRadius: 20.0,
                      highlightColor: ColorManager.darkColor,
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _iconSize = 50;
                            _borderSize = 4.0;
                            _glowBlur = 30.0;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _iconSize = 30;
                            _borderSize = 2.0;
                            _glowBlur = 20.0;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.whiteColor,
                                border: Border.all(
                                  color: ColorManager.whiteColor,
                                  width: _borderSize,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorManager.whiteColor,
                                    blurRadius: _glowBlur,
                                    spreadRadius: 5,
                                    offset: const Offset(10, 10),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.play_arrow_outlined,
                                  size: _iconSize,
                                  color: ColorManager.darkColor,
                                  shadows: [
                                    Shadow(
                                      color: ColorManager.whiteColor,
                                      blurRadius: _glowBlur,
                                      offset: const Offset(10, 10),
                                    ),
                                  ],
                                ),
                                splashColor: ColorManager.orangeColor,
                                splashRadius: 20.0,
                                highlightColor: ColorManager.orangeColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Play Trailer",
                              style: TextStyles.appText.copyWith(color: ColorManager.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Spider-Man: No Way Home",
                          style: TextStyle(
                            fontSize: 24,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.darkColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            ...["Action", "Adventure", "Fantasy"].map(
                              (genre) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  border: Border.all(color: ColorManager.tealColor),
                                  borderRadius: BorderRadius.circular(4),
                                  color: ColorManager.tealColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(genre),
                              ),
                            ).toList(),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: ColorManager.orangeColor, size: 24),
                            SizedBox(width: 4),
                            Text(
                              "8.7/10 IMDb",
                              style: TextStyles.appBarTitle.copyWith(color: ColorManager.darkColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyles.appText.copyWith(color: ColorManager.darkColor, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "With Spider-Man's identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other realms appear, forcing Peter to discover what it truly means to be Spider-Man.",
                              style: TextStyles.appText.copyWith(color: ColorManager.darkColor),
                              maxLines: 5,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Cast",
                          style: TextStyles.appText.copyWith(color: ColorManager.darkColor, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isBookmarked = !isBookmarked;
                          });
                        },
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked ? ColorManager.blueColor : ColorManager.darkColor,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorManager.darkColor,
        unselectedItemColor: ColorManager.whiteColor,
        backgroundColor: ColorManager.tealColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        iconSize: 24,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: items
            .map((item) => BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Icon(item.icon),
                  ),
                  label: item.label,
                ))
            .toList(),
      ),
    );
  }
}