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
- [SuperCupertinoNavigationBar Attributes](#SuperCupertinoNavigationBar-Attributes)
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

**SuperCupertinoNavigationBar** widget has **CustomScrollView** widget in it so you should place your children in **slivers** key whose type List.

```dart
CupertinoPageScaffold(  //inside CupertinoPageScaffold
  child: SuperCupertinoNavigationBar(
      transitionBetweenRoutes: false, // if don't want transition animation set false / default is true
      largeTitleType: AppBarType.LargeTitleWithFloatedSearch, // Set desired AppBarType
      avatarModel: AvatarModel(
        avatarUrl: null,
        avatarIsVisible: true, // Avatar is hidden as default, if you want to set visible, simply set true
        onTap: () => print("some event"),
      ),
      largeTitle: const Text('Home'),
      searchFieldDecoration: SearchFieldDecoration(
          hideSearchBarOnInit: true,
          searchFieldBehaviour: SearchFieldBehaviour.ShowResultScreenAfterFieldInput,
      ),
      slivers: [
        // Any Sliver here
      ],
  ),
);
```

#### SuperCupertinoNavigationBar Attributes

| Attribute                 | Type                          | Annotation                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|---------------------------|-------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| largeTitle                | Widget                        | Supply Text() widget in order to get right transition animation                                                                                                                                                                                                                                                                                                                                                                                                   |
| leading                   | Widget                        | You can add desired Widget left top of Navbar                                                                                                                                                                                                                                                                                                                                                                                                                     |
| automaticallyImplyLeading | bool                          | used for removing the back button, from the second screen(This comes when the user navigates from the first screen to the second screen, which is the flutter default behavior). To show back button/leading widget flutter occupy some space at the left side of AppBar.                                                                                                                                                                                         |
| automaticallyImplyTitle   | bool                          | If true and [largeTitle] is null, automatically fill in a Text() widget with the current route's `title` if the route is a CupertinoPageRoute. If largeTitle widget is not null, this parameter has no effect.                                                                                                                                                                                                                                                    |
| alwaysShowMiddle          | bool                          | This should be set to false if you only want to show [largeTitle] in expanded state and [middle] in collapsed state.                                                                                                                                                                                                                                                                                                                                              |
| physics                   | ScrollPhysics                 | SuperCupertinoNavigationBar has CustomScrollView in it. Physic is used to set CustomScrollView's physics.                                                                                                                                                                                                                                                                                                                                                         |
| previousPageTitle         | String                        | Manually specify the previous route's title when automatically implying the leading back button. Overrides the text shown with the back chevron instead of automatically showing the previous CupertinoPageRoute's title when automaticallyImplyLeading is true. Has no effect when leading is not null or if automaticallyImplyLeading is false.                                                                                                                 |
| middle                    | Widget                        | Widget to place in the middle of the navigation bar. Normally a title or a segmented control. If null and automaticallyImplyMiddle is true, an appropriate Text title will be created if the current route is a CupertinoPageRoute and has a title.                                                                                                                                                                                                               |
| trailing                  | Widget                        | Widget to place at the end of the navigation bar. Normally additional actions taken on the page such as a search or edit function.                                                                                                                                                                                                                                                                                                                                |
| border                    | Border                        | The direction in which the widget content will line up                                                                                                                                                                                                                                                                                                                                                                                                            |
| backgroundColor           | Color                         | The background color of the navigation bar. If it contains transparency, the tab bar will automatically produce a blurring effect to the content behind it. Defaults to CupertinoTheme's scaffolBackgroundColor if null.                                                                                                                                                                                                                                          |
| collapsedBackgroundColor  | Color                         | The background color of the collapsed navigation bar. If it contains transparency, the tab bar will automatically produce a blurring effect to the content behind it. Defaults to CupertinoTheme's barBackgroundColor if null.                                                                                                                                                                                                                                    |
| brightness                | Brightness                    | The brightness of the specified backgroundColor. Setting this value changes the style of the system status bar. Typically used to increase the contrast ratio of the system status bar over backgroundColor. If set to null, the value of the property will be inferred from the relative luminance of backgroundColor.                                                                                                                                           |
| padding                   | EdgeInsetsDirectional         | Padding for the contents of the navigation bar. If null, the navigation bar will adopt the following defaults: Vertically, contents will be sized to the same height as the navigation bar itself minus the status bar. Horizontally, padding will be 16 pixels according to iOS specifications unless the leading widget is an automatically inserted back button, in which case the padding will be 0. Vertical padding won't change the height of the nav bar. |
| transitionBetweenRoutes   | bool                          | Whether to transition between navigation bars. When transitionBetweenRoutes is true, this navigation bar will transition on top of the routes instead of inside it if the route being transitioned to also has a CupertinoNavigationBar or a CupertinoSliverNavigationBar with transitionBetweenRoutes set to true.                                                                                                                                               |
| heroTag                   | Object                        | Tag for the navigation bar's Hero widget if transitionBetweenRoutes is true. Defaults to a common tag between all CupertinoNavigationBar and CupertinoSliverNavigationBar instances of the same Navigator. With the default tag, all navigation bars of the same navigator can transition between each other as long as there's only one navigation bar per route.                                                                                                |
| stretch                   | bool                          | This specifies navbar behavior when negative scroll has been done. It moves with scroll contents when it's true. But it will be static on scrolling.                                                                                                                                                                                                                                                                                                              |
| slivers                   | List<Widget>                  | SuperCupertinoNavigationBar has CustomScrollView so place all of your children place here as Sliver Widget such as SliverToBoxAdapter etc.                                                                                                                                                                                                                                                                                                                        |
| scrollController          | ScrollController              | SuperCupertinoNavigationBar has own scrollController but if you want to add scrollController as custom, you can set here. this will be used as primary scrollController                                                                                                                                                                                                                                                                                           |
| appBarType                | AppBarType (Enum)             | AppBarType is an enum and it sets Appbar as Large Title or Normal Navbar and whether it has Search Bar or not. **Values:** LargeTitleWithPinnedSearch, LargeTitleWithFloatedSearch, LargeTitleWithoutSearch, NormalNavbarWithPinnedSearch, NormalNavbarWithFloatedSearch                                                                                                                                                                                          |
| searchFieldDecoration     | SearchFieldDecoration (Model) | This is Search Field Model which you can find extended information below                                                                                                                                                                                                                                                                                                                                                                                          |
| avatarModel               | AvatarModel (Model)           | This is Avatar Model which you can find extended information below                                                                                                                                                                                                                                                                                                                                                                                                |
---

[linkedin]: https://www.linkedin.com/in/kaz%C4%B1m-selman-poyraz-0048b7143/
[github]: https://github.com/kspo