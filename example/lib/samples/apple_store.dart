import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:http/http.dart' as http;
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:untitled/models/product_list.model.dart';
import 'package:untitled/utils/general.dart';

class AppleStore extends StatefulWidget {
  const AppleStore({super.key});

  @override
  State<AppleStore> createState() => _AppleStoreState();
}

class _AppleStoreState extends State<AppleStore> {
  List<Products> _products = [];
  bool onSubmitted = false;
  final general = General.instance;

  Future<List<Products>> search(String text) async {
    try {
      var client = http.Client();

      final response = await client
          .get(Uri.parse('https://dummyjson.com/products/search?q=$text'));

      // print(UserList.fromJson(json.decode(response.body)).users!);
      if (response.statusCode == 200) {
        return ProductList.fromJson(json.decode(response.body)).products!;
      } else {
        throw Exception('Something Goes Wrong');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Widget createSuggestionList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => setState(() {
          onSubmitted = true;
        }),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              color: CupertinoColors.systemBlue,
            ),
            const SizedBox(
              width: 15,
            ),
            Text("${_products[index].title}")
          ],
        ),
      ),
      separatorBuilder: (c, i) => Divider(
        color: Colors.grey.withOpacity(0.25),
        height: 20,
      ),
      itemCount: _products.length,
    );
  }

  Widget createSearchList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  _products[index].thumbnail,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_products[index].title}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${_products[index].category}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: CupertinoTheme.of(context).barBackgroundColor,
                  ),
                  child: Text(
                    "Download",
                    style: general
                        .getLinkStyle(context)
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 75,
                child: RatingStars(
                  value: _products[index].rating.toDouble(),
                  starBuilder: (index, color) => Icon(
                    Icons.star,
                    color: color,
                    size: 15,
                  ),
                  starCount: 5,
                  starSize: 13,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: true,
                  valueLabelVisibility: false,
                  animationDuration: const Duration(milliseconds: 1000),
                  valueLabelPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  valueLabelMargin: const EdgeInsets.only(right: 8),
                  starOffColor: CupertinoColors.systemGrey.withOpacity(0.25),
                  starColor: CupertinoColors.systemGrey,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "${_products[index].brand}",
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 75,
                child: Text(
                  "${_products[index].category}",
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    _products[index].images![0],
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    _products[index].images![0],
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    _products[index].images![0],
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      separatorBuilder: (c, i) => Divider(
        color: Colors.grey.withOpacity(0.25),
        height: 50,
      ),
      itemCount: _products.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SuperScaffold(
        onCollapsed: (val) {
          print("collapsed => $val");
        },
        stretch: true,
        appBar: SuperAppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Text(
            "Search",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          height: 40,
          searchBar: SuperSearchBar(
            resultColor: Colors.black,
            enabled: true,
            scrollBehavior: SearchBarScrollBehavior.pinned,
            resultBehavior: SearchBarResultBehavior.visibleOnInput,
            placeholderText: "Game, Apps, Stories and More",
            onChanged: (text) {
              search(text).then((value) {
                _products = value;
                onSubmitted = false;
                setState(() {});
              });
            },
            onSubmitted: (text) {
              search(text).then((value) {
                _products = value;
                onSubmitted = true;
                setState(() {});
              });
            },
            searchResult:
                onSubmitted ? createSearchList() : createSuggestionList(),
          ),
          largeTitle:
              SuperLargeTitle(height: 45, largeTitle: "Search", actions: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/profile.png",
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
            )
          ]),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: Row(
                  children: [
                    Text(
                      "Explore",
                      style: general.getSubtitle(context),
                    ),
                  ],
                ),
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 4,
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                crossAxisCount: 2,
                children: <Widget>[
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.search,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Just Another Game",
                        style: general.getLinkStyle(context),
                      ),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.search,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Nur ein weiteres Spiel",
                        style: general.getLinkStyle(context),
                      ),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.search,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "또 다른 게임",
                        style: general.getLinkStyle(context),
                      ),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.search,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Just Alius Ludus",
                        style: general.getLinkStyle(context),
                      ),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.search,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Juste un autre jeu",
                        style: general.getLinkStyle(context),
                      ),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.search,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Solo un altro gioco",
                        style: general.getLinkStyle(context),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  bottom: 15.0,
                ),
                child: Row(
                  children: [
                    Text(
                      "Suggested",
                      style: general.getSubtitle(context),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.withOpacity(0.25),
                  indent: 85,
                ),
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                itemBuilder: (c, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset("assets/app_icon_${index % 8}.png"),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Apple App",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Opacity(
                            opacity: 0.75,
                            child: Text(
                              "Start a custom timer and turn on your focus until it's done",
                              style: TextStyle(fontSize: 15),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: CupertinoTheme.of(context).barBackgroundColor,
                        ),
                        child: Text(
                          "Download",
                          style: general
                              .getLinkStyle(context)
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
                itemCount: 50,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: CupertinoColors.systemBlue,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        currentIndex: 4,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.today_fill), label: "World Wlock"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.rocket_fill), label: "Alarms"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_stack_3d_up_fill),
              label: "World Wlock"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.game_controller_solid),
              label: "Alarms"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), label: "Alarms")
        ],
      ),
    );
  }
}

@immutable
class AppleStoreHeader extends StatelessWidget {
  const AppleStoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 7.0, vertical: 1.5),
              decoration: BoxDecoration(
                  color: const Color(0xff2f2f37),
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: Colors.white12,
                    width: 1,
                  )),
              child: const Row(
                children: [
                  Icon(Icons.filter_list),
                  Badge(
                    label: Text(
                      "1",
                      style: TextStyle(
                        color: CupertinoColors.systemBlue,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 7.0,
                right: 1,
                top: 1,
                bottom: 1,
              ),
              decoration: BoxDecoration(
                  color: const Color(0xff2f2f37),
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: Colors.white12,
                    width: 1,
                  )),
              child: const Row(
                children: [
                  Text("Open"),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white12,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 7.0,
                right: 1,
                top: 1,
                bottom: 1,
              ),
              decoration: BoxDecoration(
                  color: const Color(0xff2f2f37),
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: Colors.white12,
                    width: 1,
                  )),
              child: const Row(
                children: [
                  Text("Created"),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white12,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 7.0,
                right: 1,
                top: 1,
                bottom: 1,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff2f2f37),
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  color: Colors.white12,
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  Text("Visibility"),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white12,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 7.0,
                right: 1,
                top: 1,
                bottom: 1,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff2f2f37),
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  color: Colors.white12,
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  Text("Organization"),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white12,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 7.0,
                right: 1,
                top: 1,
                bottom: 1,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff2f2f37),
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  color: Colors.white12,
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  Text("Repository"),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
