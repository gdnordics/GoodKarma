import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/models/app_user.dart';
import 'package:good_karma_app/models/user_data.dart';
import 'package:good_karma_app/screens/event/create_event_screen.dart';
import 'package:good_karma_app/screens/home/eula_page.dart';
import 'package:good_karma_app/screens/home/explore_page.dart';
import 'package:good_karma_app/screens/home/info_page.dart';
import 'package:good_karma_app/screens/home/my_events_page.dart';
import 'package:good_karma_app/screens/home/profile_page.dart';
import 'package:good_karma_app/screens/loading/main_loading_screen.dart';
import 'package:good_karma_app/screens/login/login_screen.dart';
import 'package:good_karma_app/screens/search/search_screen.dart';
import 'package:good_karma_app/services/auth_service.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:good_karma_app/widgets/karma_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late int currentIndex = 0;
  late String selectedTab = "explore";

  @override
  void initState() {
    super.initState();
  }

  void onLogout() {
    Provider.of<AuthService>(context, listen: false).logout();
    Navigator.of(context)
        .pushReplacement(SlideRightRoute(page: const LoginScreen()));
  }

  Future<AppUser> setupCurrentUser(BuildContext ctx) async {
    UserData data =
        Provider.of<UserData>(ctx, listen: false);
    var user = await Provider.of<DatabaseService>(ctx, listen: false)
        .getUser(data.currentUserId!);
    data.currentUserFullName =
        user.name;
    return user;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onGoBack(dynamic _) {
    setState(() {});
  }

  void onExplorePressed() {
    setState(() {
      currentIndex = 0;
      selectedTab = "explore";
    });
  }

  void onMyEventsPressed() {
    setState(() {
      currentIndex = 1;
      selectedTab = "myevents";
    });
  }

  void onProfilePressed() {
    setState(() {
      currentIndex = 2;
      selectedTab = "profile";
    });
  }

  void onInfoPressed() {
    setState(() {
      currentIndex = 3;
      selectedTab = "info";
    });
  }

  void onAddEventPressed() {
    Navigator.of(context)
        .push(SlideRightRoute(page: const CreateEventScreen()))
        .then(onGoBack);
  }

  void onSearchPressed() {
    debugPrint("search pressed!");
    Navigator.of(context)
        .push(SlideBottomRoute(page: const SearchScreen()))
        .then(onGoBack);
  }

  void onNotificationPressed() {
    debugPrint("notification pressed!");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: FutureBuilder<AppUser>(
      future: setupCurrentUser(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MainLoadingScreen();
        }

        AppUser user = snapshot.data!;
        if (!user.acceptedEULA) {
          return EULAPage(userId: user.id!, onAccept: onGoBack);
        }

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: backgroundColor,
          body: IndexedStack(
            index: currentIndex,
            children: [
              ExplorePage(
                  onGoBack: onGoBack, onSearchPressed: onSearchPressed),
              MyEventsPage(
                  onGoBack: onGoBack, onSearchPressed: onSearchPressed),
              ProfilePage(onLogout: onLogout),
              const InfoPage(),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
              child: KarmaBottomNavBar(
            selected: selectedTab,
            onExplorePressed: onExplorePressed,
            onMyEventsPressed: onMyEventsPressed,
            onInfoPressed: onInfoPressed,
            onAddEventPressed: onAddEventPressed,
            onProfilePressed: onProfilePressed,
          )),
        );
      },
    ));
  }
}
