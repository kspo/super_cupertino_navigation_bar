import 'dart:convert';

import 'package:example/models/user_list.model.dart';
import 'package:example/screens/apple_all_shortcuts_screen.dart';
import 'package:example/screens/apple_clock_screen.dart';
import 'package:example/screens/apple_contacts_screen.dart';
import 'package:example/screens/apple_messages_screen.dart';
import 'package:example/screens/apple_music_listen_now_screen.dart';
import 'package:example/screens/apple_music_screen.dart';
import 'package:example/screens/apple_shortcuts_gallery_screen.dart';
import 'package:example/screens/apple_store_search_screen.dart';
import 'package:example/screens/apple_tips_screen.dart';
import 'package:example/screens/large_title_actions_screen.dart';
import 'package:example/screens/large_title_search_actions_screen.dart';
import 'package:example/screens/normal_navbar_actions_screen.dart';
import 'package:example/screens/normal_navbar_search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/carousel.model.dart';

class General {
  static General? _instance;

  static General get instance {
    _instance ??= General._init();

    return _instance!;
  }

  General._init();

  List<Color> get colors => [
        const Color.fromARGB(255, 250, 158, 24),
        const Color.fromARGB(255, 154, 154, 154),
        const Color.fromARGB(255, 28, 176, 240),
        const Color.fromARGB(255, 238, 89, 95),
        const Color.fromARGB(255, 233, 119, 198),
        const Color.fromARGB(255, 132, 88, 184),
        const Color.fromARGB(255, 96, 106, 124),
        const Color.fromARGB(255, 56, 207, 231),
        const Color.fromARGB(255, 53, 196, 82),
        const Color.fromARGB(255, 15, 78, 189),
      ];

  List<SubListItem> examples = [
    SubListItem(
      icon: Icons.star,
      iconColor: Colors.amberAccent,
      title: "App Store > Search",
      screen: const AppleStoreSearchScreen(),
      imageUrl: "assets/app_icon_1.png",
    ),
    SubListItem(
      icon: Icons.search,
      iconColor: Colors.blue,
      title: "Apple Music > Search",
      screen: const AppleMusicScreen(),
      imageUrl: "assets/app_icon_7.png",
    ),
    SubListItem(
      icon: Icons.account_circle,
      iconColor: Colors.lime,
      title: "Apple Contacts",
      screen: const AppleContactsScreen(),
      imageUrl: "assets/app_icon_8.png",
    ),
    SubListItem(
      icon: Icons.message,
      iconColor: Colors.pink,
      title: "Apple Messages",
      screen: const AppleMessagesScreen(),
      imageUrl: "assets/app_icon_9.png",
    ),
    SubListItem(
      icon: Icons.app_shortcut,
      iconColor: Colors.purple,
      title: "Apple Shortcuts > All Shortcuts",
      screen: const AppleAllShortcutsScreen(),
      imageUrl: "assets/app_icon_3.png",
    ),
    SubListItem(
      icon: Icons.photo,
      iconColor: Colors.green,
      title: "Apple Shortcuts > Gallery",
      screen: const AppleShortcutsGalleryScreen(),
      imageUrl: "assets/app_icon_3.png",
    ),
    SubListItem(
      icon: Icons.tips_and_updates,
      iconColor: Colors.red,
      title: "Apple Tips",
      screen: const AppleTipsScreen(),
      imageUrl: "assets/app_icon_12.png",
    ),
    SubListItem(
      icon: Icons.health_and_safety_rounded,
      iconColor: Colors.teal,
      title: "Apple Music > Listen Now",
      screen: const AppleMusicListenNowScreen(),
      imageUrl: "assets/app_icon_7.png",
    ),
    SubListItem(
      icon: Icons.timer,
      iconColor: Colors.redAccent,
      title: "Apple Clock",
      screen: const AppleClocksScreen(),
      imageUrl: "assets/app_icon_11.png",
    ),
    SubListItem(
      icon: Icons.folder_copy,
      iconColor: Colors.deepOrangeAccent,
      title: "Apple Folders",
      screen: const AppleStoreSearchScreen(),
      imageUrl: "assets/app_icon_13.png",
    ),
  ];

  List<Carousel> listCarousel = [
    Carousel(
      title: "Large Navbar, Search, Actions",
      imageUrl: "assets/slider1.png",
      screen: const LargeTitleSearchActionsScreen(),
    ),
    Carousel(
      title: "Large Navbar, Actions",
      imageUrl: "assets/slider2.png",
      screen: const LargeTitleActionsScreen(),
    ),
    Carousel(
      title: "Normal Navbar, Search",
      imageUrl: "assets/slider3.png",
      screen: const NormalNavbarSearchScreen(),
    ),
    Carousel(
      title: "Normal Navbar, Actions",
      imageUrl: "assets/slider4.png",
      screen: const NormalNavbarActionsScreen(),
    ),
  ];

  TextStyle getLinkStyle(BuildContext context) {
    return TextStyle(
        color: CupertinoTheme.of(context).primaryColor, fontSize: 15);
  }

  TextStyle getSubtitle(BuildContext context) {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }

  showSnackBar(BuildContext context) {
    showCupertinoModalPopup(
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) => Container(
        height: 100,
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: const Text(
          "This is just snackbar triggered by appbar button",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Future<List<Widget>> searchUsers(String text) async {
    try {
      var client = http.Client();

      final response = await client
          .get(Uri.parse('https://dummyjson.com/users/search?q=$text'));

      // print(UserList.fromJson(json.decode(response.body)).users!);
      if (response.statusCode == 200) {
        return UserList.fromJson(json.decode(response.body)).users!.map((item) {
          return Row(
            children: [
              const Icon(Icons.search),
              const SizedBox(
                width: 15,
              ),
              Text("${item.firstName} ${item.lastName}")
            ],
          );
        }).toList();
      } else {
        throw Exception('Something Goes Wrong');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<List<Users>> getUsers() async {
    try {
      var client = http.Client();

      final response =
          await client.get(Uri.parse('https://dummyjson.com/users'));

      if (response.statusCode == 200) {
        return UserList.fromJson(json.decode(response.body)).users!;
      } else {
        throw Exception('Something Goes Wrong');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Widget justPlaceholder(BuildContext context, int index) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Placeholders",
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
              const Spacer(),
              GestureDetector(
                onTap: null,
                child: const Text(
                  "See All",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemBuilder: (c, i) => Container(
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? colors[i % colors.length]
                    : colors.reversed.toList()[i % colors.length],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 2.3,
              margin: const EdgeInsets.only(right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          CupertinoIcons.square_stack_fill,
                          color: Colors.white,
                          size: 30,
                        ),
                        Spacer(),
                        Icon(
                          CupertinoIcons.arrow_up_right_circle_fill,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      listCarousel[i].title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ]),
            ),
            itemCount: listCarousel.length,
          ),
        ),
        const Divider(
          color: Colors.grey,
          endIndent: 15,
          indent: 15,
          height: 50,
        ),
      ],
    );
  }
}
