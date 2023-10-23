import 'package:flutter/material.dart';
import 'package:fully_holiday/domesticcity.dart';

class CityPage extends StatefulWidget {
  const CityPage({super.key});

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage>
    with SingleTickerProviderStateMixin {
  late final tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('選擇出發地'),
      ),
      body: IntrinsicWidth(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                SearchAnchor(
                  builder: (context, controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                    );
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(5, (int index) {
                      final String item = 'item $index';
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            controller.closeView(item);
                          });
                        },
                      );
                    });
                  },
                ),
                DefaultTabController(
                  length: 2,
                  child: TabBar(
                    labelColor: Colors.black,
                    controller: tabController,
                    tabs: [
                      Tab(
                        text: "國內城市",
                      ),
                      Tab(
                        text: "國際城市",
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 300,
                  child: TabBarView(controller: tabController, children: [
                    DomesticCity(),
                    DomesticCity(),
                  ]),
                ),
              ],
            )),
      ),
    );
  }
}
