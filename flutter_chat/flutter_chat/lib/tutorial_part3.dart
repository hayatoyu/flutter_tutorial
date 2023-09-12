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

  @override
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

  late final _listController = StreamChannelListController(
    client: widget.client,
    filter: Filter.in_(
      'members', 
      [StreamChat.of(context).currentUser!.id]
    ),
    channelStateSort: const [SortOption('last_message_at')],
    limit: 20
  );

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamChannelListView(
      controller: _listController,
      itemBuilder: _channelPreviewBuilder,
      onChannelTap: (channel) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StreamChannel(
              channel: channel,
              child: const ChannelPage()
            )
          )
        );
      },
    ),
  );

  Widget _channelPreviewBuilder(
    BuildContext context,
    List<Channel> channels,
    int index,
    StreamChannelListTile defaultTile,
  ) {
    final channel = channels[index];
    final lastMessage = channel.state?.messages.reversed.firstWhere((message) => !message.isDeleted);
    final subtitle = lastMessage == null ? 'nothing yet' : lastMessage.text;
    final opacity = (channel.state?.unreadCount ?? 0) > 0 ? 1.0 : 0.5;

    return ListTile(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (_) => StreamChannel(channel: channel, child: const ChannelPage())
          )
        );
      },
      leading: StreamChannelAvatar(
        channel: channel,
      ),
      title: StreamChannelName(
        textStyle: StreamChannelPreviewTheme.of(context).titleStyle!.copyWith(
          color: StreamChatTheme.of(context).colorTheme.textHighEmphasis.withOpacity(opacity),
        ),
        channel: channel
      ),
      subtitle: Text(subtitle ?? ""),
      trailing: channel.state!.unreadCount > 0 ? CircleAvatar(
        radius: 10,
        child: Text(channel.state!.unreadCount.toString()),
      ) : const SizedBox(),
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