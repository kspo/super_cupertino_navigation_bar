
<div align="center">
  <a href="https://theksp.online" target="_blank">
    <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/logo_v2.png" width="100%"/>
  </a> 
  <h3 align="center">Super Cupertino Navigation Bar V2</h3>
  <p align="center">Flutter Extension</p>
  <p align="center" style="align: center;">

[![Linkedin: Kspoyraz](https://img.shields.io/badge/Kspoyraz-blue?logo=Linkedin&logoColor=fff)][linkedin]
[![Github: Kspo](https://img.shields.io/badge/Kspo-white?logo=Github&logoColor=000)][github]
![GitHub Licence](https://img.shields.io/github/license/kspo/super_cupertino_navigation_bar?label=Licence)
![GitHub last commit](https://img.shields.io/github/last-commit/kspo/super_cupertino_navigation_bar?label=Last+Commit)

</p>
<p align="center" style="align: center;">

[![Pub.dev: Kspoyraz](https://img.shields.io/badge/pub.dev-Super_Cupertino_Navigation_Bar-magenta?logo=dart&logoColor=magenta)][pub.dev]

[![GitHub Clones](https://img.shields.io/badge/dynamic/json?color=success&label=Github+Clone&query=count&url=https://gist.githubusercontent.com/kspo/42e4f655fdf010100a29e99faef8e918/raw/clone.json&logo=github)](https://github.com/kspo/super_cupertino_navigation_bar)
![Pub Likes](https://img.shields.io/pub/likes/super_cupertino_navigation_bar?label=pub.dev+Likes)
![Pub Points](https://img.shields.io/pub/points/super_cupertino_navigation_bar?label=Pub.dev%20Points)
![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/m/kspo/super_cupertino_navigation_bar?label=Github%20Commits)

</p>

</div>

# Super Cupertino Navigation Bar

As a developer passionate about Apple UI/UX designs, I felt that Flutter lacked sufficient support for a widget that I wanted to develop. CupertinoSliverNavigationBar does not provide support for a search bar and a bottom app bar. Additionally, even if you were to add them as Slivers, creating a built-in animation and, furthermore, implementing Apple transition animations during page transitions would be challenging. This plugin frees you from this burden.


|                                                       Floated Large Title                                                       |                                                       Pinned Large Title                                                       |                                                       Only Large Title                                                        |
|:-------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------:|
|   <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro.gif" width="150px"/>   | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_1.gif" width="150px"/>  | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_2.gif" width="150px"/> |
|                                                      Normal Navbar Floated                                                      |                                                      Normal Navbar Pinned                                                      |                                                          Only Navbar                                                          |                                                                                                                            
| <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_33.gif" width="150px"/>  | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_4.gif" width="150px"/>  | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/intro_6.png" width="150px"/> |                                                                                                                           

**It's been necessary from the beginning, and I just did it.**

<img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/cheers.gif" width="351px"/>

### Why Should You Use Super Cupertino Navigation Bar?

Using `SuperScaffold` provides several advantages and additional features compared to the standard `Scaffold` in Flutter. Here are some reasons why you might consider using `SuperScaffold`:

1. **Extended Functionality**: `SuperScaffold` extends the functionality of the standard `Scaffold` by providing additional features such as a customizable `SuperAppBar` with built-in support for large titles, search bars, and bottom bars.

2. **Configurability**: `SuperScaffold` allows you to easily configure and customize various parts of the app bar, including the title, large title, search bar, and bottom bar. This provides flexibility in adapting the app bar to the specific design requirements of your application.

3. **Search Bar Integration**: With `SuperScaffold`, you can integrate a search bar (`SuperSearchBar`) directly into the app bar, complete with customizable behavior, animation, and callbacks for handling user input.

4. **Large Title Support**: The `SuperLargeTitle` feature enables the use of large titles in the app bar, which can be particularly useful in applications with a prominent navigation hierarchy.

5. **Bottom Bar Options**: The `SuperAppBarBottom` feature allows you to add a bottom bar below the app bar, providing additional space for interactive elements or navigation controls.

6. **Consistent Theming**: `SuperScaffold` includes theming options to ensure a consistent look and feel throughout your application. You can customize colors, borders, and other visual aspects easily.

## Okay! Let's dive deep!

#### [**Examples**](https://github.com/kspo/super_cupertino_navigation_bar/tree/main/example/lib/samples)

Before the table of content, hereby, you can find all of example from [here](https://github.com/kspo/super_cupertino_navigation_bar/tree/main/example/lib/samples). Enjoy!

# Super Cupertino Navigation Bar

- [Getting Started](#getting-started)
  - [Add Dependency](#add-dependency)
  - [Import Package](#import-package)
  - [Easy to Use](#easy-to-use)

# SuperScaffold

- [Additional Features and Customization Options](#additional-features-and-customization-options)
- [SuperAppBar](#superappbar)
  - [Parameters](#parameters)
  - [Example Usage](#example-usage)
- [SuperLargeTitle](#superlargetitle)
  - [Parameters](#parameters-1)
  - [Example Usage](#example-usage-1)
- [SuperSearchBar](#supersearchbar)
  - [Parameters](#parameters-2)
  - [SearchResultHeader Class](#searchresultheader-class)
  - [Enums](#enums)
  - [Example Usage](#example-usage-2)
- [SuperAppBarBottom](#superappbarbottom)
  - [Parameters](#parameters-3)
  - [Example Usage](#example-usage-3)


# Getting Started

#### Add dependency

```yaml
dependencies:
  super_cupertino_navigation_bar: latest_version
```

#### Add import package

```dart
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
```

#### Easy to use

```dart
SuperScaffold(
  appBar: SuperAppBar(
    title: Text("Hello SuperScaffold"),
    largeTitle: SuperLargeTitle(
      enabled: true,
      largeTitle: "Welcome",
    ),
    searchBar: SuperSearchBar(
      enabled: true,
      resultBehavior: SearchBarResultBehavior.visibleOnInput,
      onChanged: (query) {
        // Search Bar Changes
      },
      onSubmitted: (query) {
        // On Search Bar submitted
      },
    ),
    bottom: SuperAppBarBottom(
      enabled: true,
      height: 40,
      child: YourCustomBottomWidget(), // Any widget of yours
    ),
  ),
  body: [
    Container(
      alignment: Alignment.center,
      child: Text("This is the body of SuperScaffold"),
    ),
  ],
  backgroundColor: Colors.white,
);
```

# SuperScaffold

`SuperScaffold` is an extended version of the Flutter `Scaffold` widget with additional features and customization options.

## Additional Features and Customization Options

- **`stretch`**: If `true`, the `SuperScaffold` will stretch to occupy the available space.
- **`transitionBetweenRoutes`**: If `true`, enables transition animations between routes.
- **`measures`**: Additional measures for various components inside the `SuperScaffold`.
- **`appBar`**: An instance of `SuperAppBar` for customizing the app bar.
- **`onCollapsed`**: A callback function invoked when the app bar is collapsed.
- **`backgroundColor`**: The background color of the `SuperScaffold`.
- **`scrollController`**: A custom scroll controller for the body of the `SuperScaffold`.
- **`body`**: is a List<Widget> .
- ... (All other attributes of the default `Scaffold` are available)

Feel free to use this extended `SuperScaffold` in your Flutter application for enhanced customization and additional features. Adjust the parameters according to your application's requirements.

## SuperAppBar

`SuperAppBar` is a customizable Flutter widget that extends the functionality of the default `AppBar`. It provides enhanced features such as a search bar, large title, and additional customization options.

### Constructor

| Parameter                   | Description                                                                                                                 | Default Value    |
|-----------------------------|-----------------------------------------------------------------------------------------------------------------------------|------------------|
| `title`                     | The main title of the app bar. If a `Text` widget is provided, it ensures that a default style is set if none is provided.  | -                |
| `actions`                   | Additional widgets to display on the app bar, typically icons or buttons.                                                   | -                |
| `height`                    | The height of the app bar.                                                                                                  | `kToolbarHeight` |
| `leadingWidth`              | The width of the leading widget.                                                                                            | -                |
| `leading`                   | A widget to display before the `title`. If `automaticallyImplyLeading` is true, this widget will represent the back button. | -                |
| `automaticallyImplyLeading` | Whether to automatically include a leading widget (typically a back button).                                                | `true`           |
| `titleSpacing`              | The space between the leading widget and the title.                                                                         | `15`             |
| `previousPageTitle`         | The title of the previous page when using the back button.                                                                  | "Back"           |
| `alwaysShowTitle`           | Whether to always show the title, regardless of whether it fits within the app bar.                                         | `false`          |
| `searchBar`                 | An optional `SuperSearchBar` widget for search functionality.                                                               | -                |
| `largeTitle`                | An optional `SuperLargeTitle` widget for displaying a large title.                                                          | -                |
| `bottom`                    | An optional `SuperAppBarBottom` widget for additional content at the bottom of the app bar.                                 | -                |
| `backgroundColor`           | The background color of the app bar.                                                                                        | -                |
| `bottomBorder`              | The border at the bottom of the app bar.                                                                                    | -                |
| `shadowColor`               | The color of the app bar's shadow.                                                                                          | -                |

### Example Usage

```dart
SuperAppBar(
  title: Text("My App"),
  actions: const [Icon(Icons.search), Icon(Icons.more_vert)],
  height: 80,
  leading: const Icon(Icons.arrow_back),
  automaticallyImplyLeading: true,
  titleSpacing: 20,
  previousPageTitle: "Home",
  alwaysShowTitle: false,
  searchBar: SuperSearchBar(),
  largeTitle: SuperLargeTitle(),
  bottom: SuperAppBarBottom(),
  backgroundColor: Colors.blue,
  bottomBorder: const BorderSide(color: Colors.black, width: 1),
  shadowColor: Colors.grey,
);
```

Feel free to customize the `SuperAppBar` based on your specific design requirements in your Flutter application!

---

# SuperLargeTitle

`SuperLargeTitle` is a Flutter widget designed to display a large and prominent title. It offers customization options for styling and layout.

### Parameters:

| Parameter    | Description                                                                      | Default Value                            |
|--------------|----------------------------------------------------------------------------------|------------------------------------------|
| `enabled`    | Whether the large title is enabled or disabled.                                  | `true`                                   |
| `largeTitle` | The text to be displayed as the large title.                                     | "Hello Super Human"                      |
| `actions`    | A list of additional widgets or actions to be displayed next to the large title. | `null`                                   |
| `textStyle`  | The style of the large title text.                                               | See default values below                 |
| `height`     | The height of the large title.                                                   | `kToolbarHeight`                         |
| `padding`    | The padding around the large title.                                              | `EdgeInsets.symmetric(horizontal: 15.0)` |

## Example Usage

```dart
SuperLargeTitle(
  enabled: true,
  largeTitle: "Hello Flutter",
  actions: [
    IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        // Handle settings button press
      },
    ),
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        // Handle search button press
      },
    ),
  ],
  textStyle: TextStyle(
    color: Colors.blue,
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
  ),
  height: 80.0,
  padding: EdgeInsets.symmetric(horizontal: 20.0),
)
```

Feel free to customize the `SuperLargeTitle` in your Flutter application to create visually appealing and informative large titles.

# SuperSearchBar

`SuperSearchBar` is a customizable Flutter widget that provides a flexible and feature-rich search bar for your application. It includes various options for styling, behavior, and interaction.

### Parameters:

| Parameter              | Description                                                             | Default Value                                          |
|------------------------|-------------------------------------------------------------------------|--------------------------------------------------------|
| `cancelButtonText`     | The text displayed on the cancel button.                                | "Cancel"                                               |
| `cancelTextStyle`      | The style of the cancel button's text.                                  | TextStyle(color: CupertinoColors.systemBlue)           |
| `placeholderTextStyle` | The style of the placeholder text.                                      | TextStyle(color: CupertinoColors.systemGrey)           |
| `placeholderText`      | The placeholder text displayed in the search bar.                       | "Search"                                               |
| `prefixIcon`           | The icon displayed as a prefix in the search bar.                       | Icon(CupertinoIcons.search)                            |
| `actions`              | Additional actions displayed in the search bar.                         | []                                                     |
| `scrollBehavior`       | The scroll behavior of the search bar.                                  | SearchBarScrollBehavior.floated                        |
| `height`               | The height of the search bar.                                           | 35.0                                                   |
| `padding`              | The padding of the search bar.                                          | EdgeInsets.symmetric(horizontal: 15.0)                 |
| `animationBehavior`    | The animation behavior of the search bar.                               | SearchBarAnimationBehavior.top                         |
| `animationDuration`    | The duration of the search bar animation.                               | Duration(milliseconds: 250)                            |
| `searchResult`         | The widget displayed as a search result.                                | Text(".", style: TextStyle(color: Colors.transparent)) |
| `resultBehavior`       | The visibility behavior of the search result.                           | SearchBarResultBehavior.visibleOnFocus                 |
| `enabled`              | Whether the search bar is enabled or disabled.                          | true                                                   |
| `textStyle`            | The style of the text entered in the search bar.                        | TextStyle()                                            |
| `onChanged`            | Callback function triggered when the text in the search bar changes.    | -                                                      |
| `onFocused`            | Callback function triggered when the search bar gains or loses focus.   | -                                                      |
| `onSubmitted`          | Callback function triggered when the user submits the search bar.       | -                                                      |
| `searchController`     | The `TextEditingController` for controlling the text in the search bar. | -                                                      |
| `searchFocusNode`      | The `FocusNode` for controlling the focus state of the search bar.      | -                                                      |
| `backgroundColor`      | The background color of the search bar.                                 | CupertinoColors.tertiarySystemFill                     |
| `resultColor`          | The color of the search result.                                         | -                                                      |

## SearchResultHeader Class

```dart
class SearchResultHeader extends StatelessWidget {
  const SearchResultHeader({
    super.key,
    required this.height,
    required this.child,
  });
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: child,
    );
  }
}
```

### Parameters:

| Parameter   | Description                                  |
| ----------- | -------------------------------------------- |
| `height`    | The height of the `SearchResultHeader`.       | 
| `child`     | The child widget to be displayed in the header. |

## Enums

### SearchBarScrollBehavior

```dart
enum SearchBarScrollBehavior {
  pinned,
  floated,
}
```

### SearchBarAnimationBehavior

```dart
enum SearchBarAnimationBehavior {
  top,
  steady,
}
```

### SearchBarResultBehavior

```dart
enum SearchBarResultBehavior {
  visibleOnFocus,
  visibleOnInput,
  neverVisible,
}
```

### SuperActionBehavior

```dart
enum SuperActionBehavior {
  alwaysVisible,
  visibleOnFocus,
  visibleOnUnFocus,
}
```

Feel free to integrate and customize the `SuperSearchBar` in your Flutter application to create a powerful and visually appealing search experience!

Let's look at expected behaviour;

|                                                      ShowResultScreenAfterFieldInput                                                      |                                                     ShowResultScreenAfterFieldFocused                                                     |                                                           NeverShowResultScreen                                                           |
|:-----------------------------------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------:|
| <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/search_behaviour_1.gif" width="150px"/>  | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/search_behaviour_2.gif" width="150px"/>  | <img src="https://raw.githubusercontent.com/kspo/super_cupertino_navigation_bar/main/screenshots/search_behaviour_3.gif" width="150px"/>  |

# SuperAppBarBottom

`SuperAppBarBottom` is a Flutter widget designed to provide additional content at the bottom of the `SuperAppBar`. It offers customization options for content, height, visibility, and color.

### Parameters:

| Parameter | Description                                                               | Default Value        |
|-----------|---------------------------------------------------------------------------|----------------------|
| `child`   | The widget or content to be displayed at the bottom of the `SuperAppBar`. | `SizedBox()`         |
| `height`  | The height of the content at the bottom.                                  | `35`                 |
| `enabled` | Whether the `SuperAppBarBottom` is enabled or disabled.                   | `false`              |
| `color`   | The background color of the `SuperAppBarBottom`.                          | `Colors.transparent` |

## Example Usage

```dart
SuperAppBarBottom(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
        icon: Icon(Icons.home),
        onPressed: () {
          // Handle home button press
        },
      ),
      IconButton(
        icon: Icon(Icons.notifications),
        onPressed: () {
          // Handle notifications button press
        },
      ),
      IconButton(
        icon: Icon(Icons.person),
        onPressed: () {
          // Handle profile button press
        },
      ),
    ],
  ),
  height: 50.0,
  enabled: true,
  color: Colors.blue,
)
```

Feel free to customize the `SuperAppBarBottom` in your Flutter application to add additional functionality or navigation options to your app bar.

## Questions

[Ask a question](https://stackoverflow.com/questions/ask) and ping me "k.s poyraz"

## Found an issue or have a proposal?

[Create an issue](https://github.com/kspo/super_cupertino_navigation_bar/issues/new)

## Contribute and Provide Feedback
If you wish to contribute to this project, take a look at my GitHub repository and report any issues or bugs. You can help me further improve the project!

## License
This package is licensed under the MIT License. For detailed information, check the LICENSE file.

[linkedin]: https://www.linkedin.com/in/kaz%C4%B1m-selman-poyraz-0048b7143/
[github]: https://github.com/kspo
[pub.dev]:https://pub.dev/packages/super_cupertino_navigation_bar
