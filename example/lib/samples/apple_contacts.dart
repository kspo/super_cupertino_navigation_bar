import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:untitled/models/user_list.dart';
import 'package:untitled/utils/general.dart';

enum Options { music, archive }

class AppleContacts extends StatefulWidget {
  const AppleContacts({super.key});

  @override
  State<AppleContacts> createState() => _AppleContactsState();
}

class _AppleContactsState extends State<AppleContacts> {
  ScrollController scrollController = ScrollController();
  final alphabets =
      List.generate(26, (index) => String.fromCharCode(index + 65));

  List<Users> _users = [];
  bool focused = false;

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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          Text("${_users[index].firstName} ${_users[index].lastName}"),
      separatorBuilder: (context, index) => Divider(
        color: CupertinoColors.systemGrey.withOpacity(0.35),
        height: 25,
      ),
      itemCount: _users.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SuperScaffold(
            appBar: SuperAppBar(
              backgroundColor: Colors.black.withOpacity(0.5),
              previousPageTitle: "Lists",
              leadingWidth: 100,
              title: Text(
                "Contacts",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              actions: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.add)],
              ),
              searchBar: SuperSearchBar(
                resultColor: Colors.black,
                scrollBehavior: SearchBarScrollBehavior.pinned,
                resultBehavior: SearchBarResultBehavior.visibleOnInput,
                onFocused: (value) => setState(() {
                  focused = value;
                  if (!value) _users = [];
                }),
                onChanged: (text) {
                  search(text).then((value) {
                    _users = value;
                    setState(() {});
                  });
                },
                onSubmitted: (text) {
                  search(text).then((value) {
                    _users = value;
                    setState(() {});
                  });
                },
                searchResult: SingleChildScrollView(
                  child: Column(
                    children: [
                      createResultList(),
                    ],
                  ),
                ),
              ),
              largeTitle: SuperLargeTitle(
                largeTitle: "Contacts",
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(89),
                            child: Image.asset(
                              "assets/profile.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Will Smith",
                              style: General.instance.getSubtitle(context),
                            ),
                            const Opacity(
                              opacity: 0.5,
                              child: Text(
                                "My Card",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Users>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 25),
                          separatorBuilder: (context, index) => Divider(
                            color: CupertinoColors.systemGrey.withOpacity(0.35),
                            height: 25,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Text(
                                "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}");
                          },
                        );
                      } else {
                        return const CupertinoActivityIndicator(
                          radius: 13,
                        );
                      }
                    },
                    future: General.instance.getUsers(),
                  ),
                ],
              ),
            ),
          ),
        ),
        focused
            ? const SizedBox()
            : Container(
                alignment: const Alignment(1, 0),
                padding: const EdgeInsets.only(right: 2, top: 100),
                height: MediaQuery.of(context).size.height,
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: alphabets
                        .map((alphabet) => GestureDetector(
                              onTap: () {
                                General.instance.showSnackBar(context);
                              },
                              child: Text(
                                alphabet,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: CupertinoColors.systemBlue),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              )
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    this.index,
    this.title,
    this.color = Colors.lightBlue,
  }) : super(key: key);

  final String? title;
  final int? index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('hit $index');
      },
      child: Container(
        height: 60,
        color: color,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          title ?? 'Header #$index',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _SliverLeaf extends StatelessWidget {
  const _SliverLeaf();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        color: Colors.amber,
      ),
    );
  }
}
