import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

class DomesticCity extends StatefulWidget {
  const DomesticCity({super.key});

  @override
  State<DomesticCity> createState() => _DomesticCityState();
}

class _DomesticCityState extends State<DomesticCity> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SideMenu(
          controller: sideMenu,
          style: SideMenuStyle(
            displayMode: SideMenuDisplayMode.auto,
            hoverColor: Colors.blue[100],
            selectedHoverColor: Colors.blue[100],
            selectedColor: Colors.lightBlue,
            selectedTitleTextStyle: const TextStyle(color: Colors.white),
            selectedIconColor: Colors.white,
          ),
          items: [
            SideMenuItem(
              title: "台灣",
              onTap: (index, _) {
                sideMenu.changePage(index);
              },
              icon: const Icon(Icons.home),
            ),
            SideMenuItem(
              title: "澎湖",
              onTap: (index, sideMenuController) {
                sideMenu.changePage(index);
              },
            ),
          ],
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            children: [
              Container(
                color: Colors.white,
                child: const Center(
                  child: Text(
                    '台灣',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: const Center(
                  child: Text(
                    '澎湖',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
              ),
            ],
          )
        ),
      ],
    );
  }
}
