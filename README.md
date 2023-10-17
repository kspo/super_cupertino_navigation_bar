![Static Badge](https://img.shields.io/badge/Author-KSPoyraz-blue)
[![Linkedin: Kspoyraz](https://img.shields.io/badge/Kspoyraz-blue?logo=Linkedin&logoColor=fff)][linkedin]
[![Github: Kspo](https://img.shields.io/badge/Kspo-white?logo=Github&logoColor=000)][github]
![GitHub Licence](https://img.shields.io/github/license/kspo/apple_stocks_app_clone?label=Licence)
![GitHub last commit](https://img.shields.io/github/last-commit/kspo/apple_stocks_app_clone?label=Last+Commit)

# Super Cupertino Navigation Bar

Customize your iOS-style navigation bar and elevate the user experience of your project.


As a developer who appreciates Cupertino's elegant design, wouldn't you want to add this custom package to your app in development? The Super Cupertino Navigation Bar helps you create an iOS-style navigation bar while allowing you to add a search field and customize avatars.

|                                                      Floated Large Title                                                      |                                                       Pinned Large Title                                                        |                                                        Only Large Title                                                         |                                                      Normal Navbar Floated                                                      |                                                      Normal Navbar Pinned                                                       |
|:-----------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------:|
|  <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro.gif" width="125px"/>  |  <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_1.gif" width="125px"/>  |  <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_2.gif" width="125px"/>  | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_33.gif" width="125px"/>  |  <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_4.gif" width="125px"/>  |

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
  - [AppBarType Enum](#AppBarType-Enum)
- [SearchFieldDecoration Attributes](#SearchFieldDecoration-Attributes)
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

| Attribute                 | Type                          | Annotation                                                                                                                                                                                                                                                               |
|---------------------------|-------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| largeTitle                | Widget                        | Supply Text widget in order to get right transition animation                                                                                                                                                                                                            |
| leading                   | Widget                        | You can add desired Widget left top of Navbar                                                                                                                                                                                                                            |
| automaticallyImplyLeading | bool                          | used for removing the back button, from the second screen after navigating to route                                                                                                                                                                                      |
| automaticallyImplyTitle   | bool                          | If true and [largeTitle] is null, automatically fill in a Text() widget with the current route's title                                                                                                                                                                   |
| alwaysShowMiddle          | bool                          | This should be set to false if you only want to show [largeTitle] in expanded state and [middle] in collapsed state                                                                                                                                                      |
| physics                   | ScrollPhysics                 | SuperCupertinoNavigationBar has CustomScrollView in it. Physic is used to set CustomScrollView's physics                                                                                                                                                                 |
| previousPageTitle         | String                        | Manually specify the previous route's title when automatically implying the leading back button                                                                                                                                                                          |
| middle                    | Widget                        | Widget to place in the middle of the navigation bar. Normally a title or a segmented control.                                                                                                                                                                            |
| trailing                  | Widget                        | Widget to place at the end of the navigation bar. Normally additional actions taken on the page such as a search or edit function.                                                                                                                                       |
| border                    | Border                        | The direction in which the widget content will line up                                                                                                                                                                                                                   |
| backgroundColor           | Color                         | The background color of the navigation bar. If it contains transparency, the tab bar will automatically produce a blurring effect to the content behind it. Defaults to CupertinoTheme's scaffoldBackgroundColor if null.                                                |
| collapsedBackgroundColor  | Color                         | The background color of the collapsed navigation bar. If it contains transparency, the tab bar will automatically produce a blurring effect to the content behind it. Defaults to CupertinoTheme's barBackgroundColor if null.                                           |
| brightness                | Brightness                    | The brightness of the specified backgroundColor. Setting this value changes the style of the system status bar.                                                                                                                                                          |
| padding                   | EdgeInsetsDirectional         | Padding for the contents of the navigation bar. Defaults: Vertically, sized to the same height as the navigation bar itself minus the status bar. Horizontally, padding will be 16 pixels                                                                                |
| transitionBetweenRoutes   | bool                          | Set true for transition between navigation bars                                                                                                                                                                                                                          |
| heroTag                   | Object                        | Tag for the navigation bar's Hero widget if transitionBetweenRoutes is true                                                                                                                                                                                              |
| stretch                   | bool                          | This specifies navbar behavior when negative scroll has been done. It moves with scroll contents when it's true. But it will be static on scrolling.                                                                                                                     |
| slivers                   | List[Widget]                  | SuperCupertinoNavigationBar has CustomScrollView so place all of your children place here as Sliver Widget such as SliverToBoxAdapter etc.                                                                                                                               |
| scrollController          | ScrollController              | SuperCupertinoNavigationBar has own scrollController but if you want to add scrollController as custom, you can set here. this will be used as primary scrollController                                                                                                  |
| appBarType                | AppBarType (Enum)             | AppBarType is an enum and it sets Appbar as Large Title or Normal Navbar and whether it has Search Bar or not. **Values:** LargeTitleWithPinnedSearch, LargeTitleWithFloatedSearch, LargeTitleWithoutSearch, NormalNavbarWithPinnedSearch, NormalNavbarWithFloatedSearch |
| searchFieldDecoration     | SearchFieldDecoration (Model) | This is Search Field Model which you can find extended information below                                                                                                                                                                                                 |
| avatarModel               | AvatarModel (Model)           | This is Avatar Model which you can find extended information below                                                                                                                                                                                                       |

##### AppBarType Enum

AppBarType values below;
```dart
enum AppBarType {
  LargeTitleWithPinnedSearch,
  LargeTitleWithFloatedSearch,
  LargeTitleWithoutSearch,
  NormalNavbarWithPinnedSearch,
  NormalNavbarWithFloatedSearch,
}
```

---

#### SearchFieldDecoration Attributes

| Attribute            | Type                        | Annotation                                                                                                                                                                                                     |
|----------------------|-----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| controller           | TextEditingController       | SearchField TextEditingController                                                                                                                                                                              |
| onChanged            | ValueChanged[String]        | get Text value onChange and do some Event                                                                                                                                                                      |
| onSubmitted          | ValueChanged[String]        | get Text value onSubmit and do some Event                                                                                                                                                                      |
| placeholderText      | String                      | SearchField Placeholder Text Value                                                                                                                                                                             |
| decoration           | BoxDecoration               | Style your search field                                                                                                                                                                                        |
| keyboardType         | TextInputType               | Select TextInputType                                                                                                                                                                                           |
| padding              | EdgeInsetsGeometry          | only horizontal padding is applicable                                                                                                                                                                          |
| prefixIconColor      | Color                       |                                                                                                                                                                                                                |
| placeholderColor     | Color                       |                                                                                                                                                                                                                |
| prefixInsets         | EdgeInsetsGeometry          | padding around prefix icon                                                                                                                                                                                     |
| prefixIcon           | Widget                      | Select desired Icon, default is Icon(CupertinoIcons.search)                                                                                                                                                    |
| suffixInsets         | EdgeInsetsGeometry          | padding around suffix icon                                                                                                                                                                                     |
| suffixIcon           | Icon                        | Select desired Icon, default is Icon(CupertinoIcons.xmark_circle_fill)                                                                                                                                         |
| onSuffixTap          | VoidCallback                | No return value supplied. Just Clears th search field and you can do some event                                                                                                                                |
| onCancelTap          | VoidCallback                | No return value supplied. Just Clears th search field and cancels search actions. Also you can do some event                                                                                                   |
| paddingLeft          | double                      |                                                                                                                                                                                                                |
| paddingRight         | double                      |                                                                                                                                                                                                                |
| cancelButtonName     | String                      |                                                                                                                                                                                                                |
| cancelButtonStyle    | TextStyle                   |                                                                                                                                                                                                                |
| cursorColor          | Color                       |                                                                                                                                                                                                                |
| onFocused            | ValueChanged[bool]          | triggers desired event on search field focus                                                                                                                                                                   |
| hideSearchBarOnInit  | bool                        | this is applicable only LargeTitleWithFloatedSearch and NormalNavbarWithFloatedSearch                                                                                                                          |
| searchFieldBehaviour | SearchFieldBehaviour (Enum) | This specifies result screen behavior. 3 behaviour may be set: <p>**ShowResultScreenAfterFieldInput, ShowResultScreenAfterFieldFocused, NeverShowResultScreen.**</p> [Shown below](#SearchFieldBehaviour-Enum) |
| searchResultHeader   | SearchResultHeader (Model)  | This is just model which is required to set height and child attributes                                                                                                                                        |
| searchResultChildren | List[Widget]                | This appears according to SearchFieldBehaviour. You can set children here after desired action such as onChanged, onSubmitted etc.                                                                             |

##### SearchFieldBehaviour Enum

SearchFieldBehaviour values below;
```dart
enum SearchFieldBehaviour {
  ShowResultScreenAfterFieldInput,
  ShowResultScreenAfterFieldFocused,
  NeverShowResultScreen,
}
```

Let's look at expected behaviour;

|                                                      ShowResultScreenAfterFieldInput                                                      |                                                     ShowResultScreenAfterFieldFocused                                                     |                                                           NeverShowResultScreen                                                           |
|:-----------------------------------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------:|
| <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/search_behaviour_1.gif" width="125px"/>  | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/search_behaviour_2.gif" width="125px"/>  | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/search_behaviour_3.gif" width="125px"/>  |

## Contribute and Provide Feedback
If you wish to contribute to this project, take a look at our GitHub repository and report any issues or bugs. You can help us further improve the project!

## License
This package is licensed under the MIT License. For detailed information, check the LICENSE file.

[linkedin]: https://www.linkedin.com/in/kaz%C4%B1m-selman-poyraz-0048b7143/
[github]: https://github.com/kspo