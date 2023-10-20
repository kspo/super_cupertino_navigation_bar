import 'package:example/screens/default_navbar_actions_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvelous_carousel/marvelous_carousel.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import 'general.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _general = General.instance;
  bool showDummy = false;

  void setClosed() => setState(() {
        showDummy = false;
      });
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SuperCupertinoNavigationBar(
        // transitionBetweenRoutes: false,
        appBarType: AppBarType.LargeTitleWithPinnedSearch,
        avatarModel: AvatarModel(
          avatarUrl: null,
          avatarIsVisible: true,
          onTap: () => _general.showSnackBar(context),
        ),
        stretch: true,
        largeTitle: const Text('Home'),
        alwaysShowMiddle: false,
        searchFieldDecoration: SearchFieldDecoration(
          hideSearchBarOnInit: true,
          searchFieldBehaviour:
              SearchFieldBehaviour.ShowResultScreenAfterFieldFocused,
          onCancelTap: setClosed,
          onSuffixTap: setClosed,
          onChanged: (text) {
            setState(() {
              if (text.length >= 3) {
                showDummy = true;
              } else {
                showDummy = false;
              }
            });
          },
          searchResultChildren: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "This search field has no search action. This is just show off 😎",
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "But you can place here any widget conditionally! For example;",
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Write 3 chars to search field",
                textAlign: TextAlign.center,
              ),
            ),
            AnimatedCrossFade(
              firstChild: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "This can be placeholder",
                  style: TextStyle(color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
              secondChild: _general.dummyContact(),
              crossFadeState: showDummy
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250),
            ),
          ],
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 202,
              child: MarvelousCarousel(
                scrollDirection: Axis.horizontal,
                dotsVisible: false,
                margin: 0,
                opacity: 0.5,
                viewportFraction: 0.95,
                children: _general.listCarousel
                    .map(
                      (e) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute<Widget>(
                            builder: (BuildContext context) {
                              return e.screen;
                            },
                          ),
                        ),
                        child: Container(
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.green, Colors.blueAccent],
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 170,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(15)),
                                        child: SizedBox(
                                          width: 225,
                                          child: Image.asset(
                                            e.imageUrl,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Examples",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "Used only for demonstration",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).barBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.withOpacity(0.4),
                      indent: 50,
                      height: 25,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute<Widget>(
                          builder: (BuildContext context) {
                            return _general.examples[i].screen;
                          },
                        ),
                      ),
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            _general.examples[i].imageUrl == null
                                ? Icon(
                                    _general.examples[i].icon,
                                    color: _general.examples[i].iconColor,
                                  )
                                : SizedBox(
                                    height: 35,
                                    width: 35,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                          _general.examples[i].imageUrl!),
                                    ),
                                  ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(_general.examples[i].title),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_rounded,
                            )
                          ],
                        ),
                      ),
                    ),
                    itemCount: _general.examples.length,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notices",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "Some Notices For Demo",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).barBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute<Widget>(
                        builder: (BuildContext context) {
                          return const DefaultNavbarActionsScreen();
                        },
                      ),
                    ),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(15),
                      child: const Row(
                        children: [
                          Icon(
                            CupertinoIcons.app_badge_fill,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Default Navbar"),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_rounded,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
