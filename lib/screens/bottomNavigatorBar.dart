import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ika_musaka/screens/accueil.dart';
import 'package:ika_musaka/screens/budgetListe.dart';
import 'package:ika_musaka/screens/depenseListe.dart';
import 'package:ika_musaka/screens/profil.dart';
import 'package:ika_musaka/services/BottomNavigationService.dart';
import 'package:ika_musaka/services/budgetService.dart';
import 'package:provider/provider.dart';

import 'DepenseListes.dart';
import 'budgetListeGetx.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage ({super.key});

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {

  int activePageIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];
  List pages = <Widget>[
    const Accueil(),
    const BudgetListe(),
    const Center(child: Text("Page 3")),
    const Center(child: Text("Page 4"))
  ];

  void _changeActivePageValue(int index){
    setState(() {
      activePageIndex = index;
    });
  }

  void _onItemTap(int index){
    Provider.of<BottomNavigationService>(context,listen: false).changeIndex(index);
    Provider.of<BudgetService>(context, listen: false).applyChange();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[activePageIndex].currentState!.maybePop();
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: Consumer<BottomNavigationService>(
          builder: (context,bottomService,child){
            WidgetsBinding.instance.addPostFrameCallback((_){
              _changeActivePageValue(bottomService.pageIndex);
            });

            return Stack(
              children: [
                _buildOffstageNavigator(0),
                _buildOffstageNavigator(1),
                _buildOffstageNavigator(2),
              ],
            );
          }
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 10.0),
          margin: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 15.0),
          decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: const Color.fromRGBO(47, 144, 98, 1),
              ),
              borderRadius: BorderRadius.circular(22.0),
              color: Colors.white
          ),
          child: BottomNavigationBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(icon: SvgPicture.asset(
                "assets/images/home_svg.svg"
                ,width: 29,height: 30,
                colorFilter: ColorFilter.mode((activePageIndex == 0)? const Color.fromRGBO(47, 144, 98, 1):Colors.black, BlendMode.srcIn),),
                  label: ""),
              BottomNavigationBarItem(icon: SvgPicture.asset(
                "assets/images/moneyTotal.svg",
                width: 29,height: 30,
                colorFilter: ColorFilter.mode((activePageIndex == 1)? const Color.fromRGBO(47, 144, 98, 1):Colors.black, BlendMode.srcIn),),
                  label: ""),
              BottomNavigationBarItem(icon: SvgPicture.asset(
                "assets/images/wallet_budget.svg",
                width: 29,height: 30,
                colorFilter: ColorFilter.mode((activePageIndex == 2)? const Color.fromRGBO(47, 144, 98, 1):Colors.black, BlendMode.srcIn),),
                  label: ""),
              BottomNavigationBarItem(icon: SvgPicture.asset(
                "assets/images/profileCircle.svg",
                width: 29,height: 30,
                colorFilter: ColorFilter.mode((activePageIndex == 3)? const Color.fromRGBO(47, 144, 98, 1):Colors.black, BlendMode.srcIn),),
                  label: ""),
            ],
            currentIndex: activePageIndex,
            onTap: _onItemTap,
          ),
        ),
        backgroundColor: Colors.white,
      )
    );
  }

  ///////////////////////////////////////////////////////////////TEST/////////////////////////
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          const Accueil(),
          const BudgetListe(),
          const DepenseListe(),
          const Profil()
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: activePageIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders![routeSettings.name]!(context),
          );
        },
      ),
    );
  }
}

/*
Consumer<BottomNavigationService>(
        builder: (context,bottomService,child){
          return pages.elementAt(bottomService.pageIndex);
        },
      )
 */
