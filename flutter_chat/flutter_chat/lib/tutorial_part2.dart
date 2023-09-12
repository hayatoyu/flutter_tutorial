import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future<void> main() async {

  const userid = "hayato";
  const userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiaGF5YXRvIn0.Wzs-ZyMirURqo0G5lK4jU5pPm91flEGbwd2tezJCehU";

  final client = StreamChatClient(
    'b4re75w9bucu',
    logLevel: Level.INFO
  );

  await client.connectUser(
    User(
      id: userid,
      name: 'Hayato'
    ), 
  userToken);

  runApp(MyApp(client: client)); 
}

class MyApp extends StatelessWidget {
  const MyApp(
    {
      super.key,
      required this.client,
    }
  );

  final StreamChatClient client;

  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => StreamChat(client: client, child: child),
      home: ChannelListPage(
        client: client
      ),
    );
  }
}

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({super.key, required this.client});

  final StreamChatClient client;

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {

  late final _controller = StreamChannelListController(
    client: widget.client,
    filter: Filter.in_(
      'members', 
      [StreamChat.of(context).currentUser!.id]
    )
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _controller.refresh,
        child: StreamChannelListView(
          controller: _controller,
          onChannelTap: (channel) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StreamChannel(
                channel: channel,
                child: const ChannelPage(),
              )
            )
          ),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StreamChannelHeader(),
      body: Column(
        children: const <Widget>[
          Expanded(
            child: StreamMessageListView(),
          ),
          StreamMessageInput()
        ],
      ),
    );
  }
}