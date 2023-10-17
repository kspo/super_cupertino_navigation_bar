![Static Badge](https://img.shields.io/badge/Author-KSPoyraz-blue)
[![Linkedin: Kspoyraz](https://img.shields.io/badge/Kspoyraz-blue?logo=Linkedin&logoColor=fff)][linkedin]
[![Github: Kspo](https://img.shields.io/badge/Kspo-white?logo=Github&logoColor=000)][github]
![GitHub Licence](https://img.shields.io/github/license/kspo/apple_stocks_app_clone?label=Licence)
![GitHub last commit](https://img.shields.io/github/last-commit/kspo/apple_stocks_app_clone?label=Last+Commit)

# Super Cupertino Navigation Bar

Customize your iOS-style navigation bar and elevate the user experience of your project.


As a developer who appreciates Cupertino's elegant design, wouldn't you want to add this custom package to your app in development? The Super Cupertino Navigation Bar helps you create an iOS-style navigation bar while allowing you to add a search field and customize avatars.

| Floated Large Title                                                                                                         | Pinned Large Title                                                                                                            | Only Large Title                                                                                                              | Normal Navbar Floated                                                                                                         | Normal Navbar Pinned                                                                                                          |
|-----------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro.gif" width="75px"/> | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_1.gif" width="75px"/> | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_2.gif" width="75px"/> | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_33.gif" width="75px"/> | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_4.gif" width="75px"/> |

**It's been necessary from the beginning, and I just did it.**

<img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/cheers.gif" width="351px"/>

### Why Should You Use Super Cupertino Navigation Bar?

1. **iOS-Style Navigation Bar**: Offer a more familiar experience to your iOS users. The Super Cupertino Navigation Bar reflects the native look and feel of iOS devices.


2. **Search Field**: Help users find content in your app more quickly and easily. Provide users with the ability to search.


3. **Avatar Customization**: Empower users to personalize their profiles. Customizable avatar addition is a fantastic way to recognize and customize users.


4. **Perfect Compatibility**: Seamlessly integrates with the Cupertino library. It works harmoniously with other components of your Flutter app.


5. **Transition Animations**: With this extension, you can have all transition animation on page route.


## Okay! Let's dive deep!

#### Table of Content

- [Getting Started](#getting-started)
- [Attributes of SuperCupertinoNavigationBar](#attributes)
  - [AppBarType Enum](#asd)
- [Attributes of SearchFieldDecoration](#attributes-of-bottombartheme)
  - [Attributes of SearchResultHeader](#asd)
  - [SearchFieldBehaviour Enum](#asd)
- [Attributes of AvatarModel](#attributes-of-mainactionbuttontheme)

### Getting Started

#### Add dependency

```yaml
dependencies:
  super_cupertino_navigation_bar: ^1.0.0
```

#### Add import package

```dart
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
```

#### Easy to use

Create a **Scaffold** widget and set **bottomNavigationBar** with **BottomBarWithSheet** like in the code below

```dart
CupertinoPageScaffold( 
child: SuperCupertinoNavigationBar(
// transitionBetweenRoutes: false,
largeTitleType: AppBarType.LargeTitleWithFloatedSearch,
avatarModel: AvatarModel(
avatarUrl: null,
avatarIsVisible: true,
onTap: () => print("object"),
),
stretch: true,
largeTitle: const Text('Home'),
collapsedBackgroundColor:
CupertinoTheme.of(context).barBackgroundColor.withOpacity(0.8),
searchFieldDecoration: SearchFieldDecoration(
hideSearchBarOnInit: true,
searchFieldBehaviour:
SearchFieldBehaviour.ShowResultScreenAfterFieldInput),
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
child: ClipRRect(
borderRadius: BorderRadius.circular(15),
child: SizedBox(
width: 382,
height: 170,
child: Image.asset(
e.imageUrl,
fit: BoxFit.cover,
),
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
)
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
```

[linkedin]: https://www.linkedin.com/in/kaz%C4%B1m-selman-poyraz-0048b7143/
[github]: https://github.com/kspo