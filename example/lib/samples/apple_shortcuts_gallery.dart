import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvelous_carousel/marvelous_carousel.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:untitled/utils/general.dart';

class ShortcutsGallery extends StatefulWidget {
  const ShortcutsGallery({super.key});

  @override
  State<ShortcutsGallery> createState() => _ShortcutsGalleryState();
}

class _ShortcutsGalleryState extends State<ShortcutsGallery> {
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
          backgroundColor: Colors.black.withOpacity(0.5),
          height: 45,
          title: Text(
            "Gallery",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          automaticallyImplyLeading: false,
          previousPageTitle: "Home",
          searchBar: SuperSearchBar(
            resultColor: Colors.black.withOpacity(0.95),
            enabled: true,
            scrollBehavior: SearchBarScrollBehavior.floated,
            animationBehavior: SearchBarAnimationBehavior.steady,
            resultBehavior: SearchBarResultBehavior.visibleOnInput,
          ),
          largeTitle: SuperLargeTitle(
            enabled: true,
            height: 50,
            largeTitle: "Gallery",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 202,
                child: MarvelousCarousel(
                  scrollDirection: Axis.horizontal,
                  dotsVisible: false,
                  margin: 0,
                  opacity: 0.5,
                  viewportFraction: 0.95,
                  children: General.instance.examples
                      .map(
                        (e) => Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  e.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                    width: 382,
                                    height: 170,
                                    child: Image.asset(
                                      "assets/slider.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (c, i) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 45.0, bottom: 15),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Placeholder",
                                style: General.instance.getSubtitle(context),
                              ),
                              const Opacity(
                                opacity: 0.75,
                                child: Text(
                                  "This is just placeholder like lorem ipsum",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 17,
                              color: CupertinoColors.systemBlue,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: General.instance.colors.length,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: i % 2 == 0
                                    ? General.instance.colors[
                                        index % General.instance.colors.length]
                                    : General.instance.colors.reversed.toList()[
                                        index % General.instance.colors.length],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(right: 15),
                              width: 150,
                              child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.square_stack_fill,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        Spacer(),
                                        Icon(
                                          CupertinoIcons
                                              .arrow_up_right_circle_fill,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "Just Square",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ]),
                            );
                          }),
                    ),
                  ],
                ),
                itemCount: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
