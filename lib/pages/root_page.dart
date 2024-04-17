import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/selected_page_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/utils/constants.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  static const String routName = '/root_page';

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    Provider.of<UserDataProvider>(context, listen: false)
        .fetchUserData(userId: FirebaseAuth.instance.currentUser!.uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;
    final SelectedPageProvider selectedPage =
        Provider.of<SelectedPageProvider>(context);
    final PageController controller =
        Provider.of<SelectedPageProvider>(context).controller;

    List<NavigationDestination> destinations = [
      NavigationDestination(
        selectedIcon: Icon(
          IconlyBold.home,
          color: color,
        ),
        icon: Icon(
          IconlyBroken.home,
          color: color,
        ),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(
          IconlyBroken.search,
          color: color,
        ),
        label: 'Search',
        selectedIcon: Icon(
          IconlyBold.search,
          color: color,
        ),
      ),
      NavigationDestination(
        icon: Icon(
          IconlyBroken.plus,
          color: color,
        ),
        label: 'Add Post',
        selectedIcon: Icon(
          IconlyBold.plus,
          color: color,
        ),
      ),
      NavigationDestination(
        icon: Icon(
          IconlyBroken.profile,
          color: color,
        ),
        label: 'Profile',
        selectedIcon: Icon(
          IconlyBold.profile,
          color: color,
        ),
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body: PageView(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          children: ConstantVariables.pages,
        ),
        bottomNavigationBar: NavigationBar(
          surfaceTintColor: Colors.white,
          indicatorColor: Colors.transparent,
          selectedIndex: selectedPage.getSelectedPageIndex,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          destinations: destinations,
          onDestinationSelected: (value) =>
              selectedPage.getNextPageIndex(value),
        ),
      ),
    );
  }
}
