import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:untitled/models/user_list.dart';
import 'package:untitled/utils/general.dart';

enum Options { music, archive }

class AppleMusic extends StatefulWidget {
  const AppleMusic({super.key});

  @override
  State<AppleMusic> createState() => _AppleMusicState();
}

class _AppleMusicState extends State<AppleMusic> {
  Options _selectedSegment = Options.music;
  List<Users> _users = [];
  bool onSubmitted = false;
  bool bottomEnabled = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Material(
        color: Colors.transparent,
        child: SuperScaffold(
          scrollController: ScrollController(),
          appBar: SuperAppBar(
            backgroundColor: Colors.black.withOpacity(0.95),
            automaticallyImplyLeading: false,
            title: Text(
              "Search",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            largeTitle: SuperLargeTitle(
              largeTitle: "Search",
              actions: [
                const Icon(
                  CupertinoIcons.profile_circled,
                  size: 35,
                  color: Colors.redAccent,
                ),
              ],
            ),
            searchBar: SuperSearchBar(
              resultColor: Colors.black,
              onFocused: (hasfocus) async {
                await Future.delayed(
                    hasfocus
                        ? const Duration(milliseconds: 400)
                        : Duration.zero,
                    () => bottomEnabled = hasfocus);
                setState(() {});
              },
              onChanged: (text) {
                print(text);
                search(text).then((value) {
                  _users = value;
                  onSubmitted = false;
                  setState(() {});
                });
              },
              onSubmitted: (text) {
                search(text).then((value) {
                  _users = value;
                  onSubmitted = true;
                  setState(() {});
                });
              },
              searchResult: SingleChildScrollView(
                child: _selectedSegment == Options.music
                    ? Column(children: [
                        const SizedBox(
                          height: 5,
                        ),
                        !onSubmitted
                            ? createSuggestionList()
                            : const SizedBox(),
                        _users.isNotEmpty
                            ? Divider(
                                indent: 15,
                                endIndent: 15,
                                color: Colors.grey.withOpacity(0.25),
                                height: 20,
                              )
                            : const SizedBox(),
                        createResultList(),
                      ])
                    : const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "this is archive section",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
              ),
            ),
            bottom: SuperAppBarBottom(
              enabled: bottomEnabled,
              height: 35,
              child: Stack(
                children: [
                  AnimatedContainer(
                    transform:
                        Matrix4.translationValues(0, !onSubmitted ? 0 : -20, 0),
                    duration: const Duration(milliseconds: 200),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 0),
                    child: AnimatedOpacity(
                      opacity: !onSubmitted ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: _headerResult(),
                    ),
                  ),
                  AnimatedContainer(
                    transform:
                        Matrix4.translationValues(0, onSubmitted ? 0 : -20, 0),
                    duration: const Duration(milliseconds: 200),
                    child: AnimatedOpacity(
                      opacity: onSubmitted ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: HeaderOnSubmitResult(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10.0, bottom: 15),
                  child: Row(
                    children: [
                      Text(
                        "Browse Categories",
                        style: General.instance.getSubtitle(context),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 20,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(100, (index) {
                      return SizedBox(
                        width: double.infinity,
                        height: 125,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 125,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/apple_music_${index % 6}.jpeg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Apple Music",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Users>> search(String text) async {
    try {
      var client = http.Client();

      final response = await client
          .get(Uri.parse('https://dummyjson.com/users/search?q=$text'));

      // print(UserList.fromJson(json.decode(response.body)).users!);
      if (response.statusCode == 200) {
        return UserList.fromJson(json.decode(response.body)).users!;
      } else {
        throw Exception('Something Goes Wrong');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Widget createResultList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 55,
            width: 55,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                _users[index].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${_users[index].firstName} ${_users[index].lastName}"),
                const SizedBox(
                  height: 5,
                ),
                const Opacity(
                  opacity: 0.5,
                  child: Text(
                    "Artist",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.chevron_forward,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      separatorBuilder: (c, i) => Divider(
        color: Colors.grey.withOpacity(0.25),
      ),
      itemCount: _users.length,
    );
  }

  Widget createSuggestionList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            color: CupertinoColors.systemPink,
          ),
          const SizedBox(
            width: 15,
          ),
          Text("${_users[index].firstName} ${_users[index].lastName}")
        ],
      ),
      separatorBuilder: (c, i) => Divider(
        color: Colors.grey.withOpacity(0.25),
        height: 20,
      ),
      itemCount: _users.length > 3 ? 3 : _users.length,
    );
  }

  Widget _headerResult() {
    return CupertinoSlidingSegmentedControl<Options>(
      backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
      thumbColor: CupertinoColors.systemGrey2,
      // This represents the currently selected segmented control.
      groupValue: _selectedSegment,

      // Callback that sets the selected segmented control.
      onValueChanged: (Options? value) {
        if (value != null) {
          setState(() {
            _selectedSegment = value;
          });
        }
      },
      children: const <Options, Widget>{
        Options.music: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Apple Music',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        Options.archive: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Archive',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
      },
    );
  }
}

//ignore: must_be_immutable
class HeaderOnSubmitResult extends StatelessWidget {
  HeaderOnSubmitResult({super.key});

  final List<String> _some = [
    "Best Matches",
    "Artists",
    "Albums",
    "Songs",
    "Lists",
    "Podcasts",
    "Stations",
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _some.length,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
          decoration: BoxDecoration(
            color: selectedIndex == index
                ? CupertinoColors.systemPink
                : Colors.transparent,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Center(
            child: Text(
              _some[index],
            ),
          ),
        );
      },
    );
  }
}
