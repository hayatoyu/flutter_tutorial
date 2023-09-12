import 'package:flutter/material.dart';

class Post {
  int id = 0;
  String author = "", name = "";

  Post(this.id, this.author, this.name);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> hot_citys = ['東京', '首爾', '雪梨', '墨爾本', '紐約'];
  List<String> hot_trips = [
    '行程1',
    '行程2',
    '行程3',
    '行程4',
    '行程5',
    '行程6',
    '行程7',
    '行程8',
    '行程9'
  ];
  List<String> hot_spots = [
    '景點1',
    '景點2',
    '景點3',
    '景點4',
    '景點5',
    '景點6',
    '景點7',
    '景點8',
    '景點9'
  ];
  List<Post> posts = [
    Post(1, "author1", "文章1"),
    Post(2, "author2", "文章2"),
    Post(3, "author3", "文章3"),
    Post(4, "author4", "文章4"),
  ];

  Widget getHotCity() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Card(
          color: Colors.blue,
          child: Container(
            width: 100,
            height: 100,
            child: Align(
              alignment: Alignment.center,
              child: Text(hot_citys[index]),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: hot_citys.length,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget getHotTrip() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Card(
          color: Colors.amber[50],
          child: Container(
            width: 80,
            height: 100,
            child: Align(
              alignment: Alignment.center,
              child: Text(hot_trips[index]),
            ),
          ),
        );
      },
      itemCount: hot_trips.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  Widget getHotSpot() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Card(
          color: Colors.blueGrey[200],
          child: Container(
            width: 80,
            height: 100,
            child: Align(
              alignment: Alignment.center,
              child: Text(hot_spots[index]),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: hot_spots.length,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget getPosts() {
    List<Widget> list = [];
    for (var i = 0; i < posts.length; i++) {
      list.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              widthFactor: 1,
              heightFactor: 1,
              child: Container(
                width: 350,
                height: 150,
                color: Colors.purpleAccent[100],
                child: ListTile(
                  title: Text(posts[i].author),
                  subtitle: Text(posts[i].name),
                ),
              )),
        ],
      ));
      list.add(SizedBox(
        height: 30,
      ));
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: list,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.large(
                    onPressed: () {},
                    backgroundColor: Colors.amber[100],
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    tooltip: "City",
                    child: const Icon(Icons.location_city),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton.large(
                    onPressed: () {},
                    backgroundColor: Colors.amber[100],
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    child: const Icon(Icons.search),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton.large(
                    onPressed: () {},
                    backgroundColor: Colors.amber[100],
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    child: const Icon(Icons.shop),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.large(
                    onPressed: () {},
                    backgroundColor: Colors.amber[100],
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    child: const Icon(Icons.local_taxi),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton.large(
                    onPressed: () {},
                    backgroundColor: Colors.amber[100],
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    child: const Icon(Icons.hotel),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton.large(
                    onPressed: () {},
                    backgroundColor: Colors.amber[100],
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    child: const Icon(Icons.wifi_tethering_rounded),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('熱門城市'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: 300, height: 100, child: getHotCity()),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('熱門行程'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 300,
                    child: getHotTrip(),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('熱門景點'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 300,
                    child: getHotSpot(),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [Text('行程分享')],
              ),
              getPosts()
            ],
          ),
        )
      ],
    );
  }
}
