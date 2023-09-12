import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const userid = "hayato";
  const userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiaGF5YXRvIn0.Wzs-ZyMirURqo0G5lK4jU5pPm91flEGbwd2tezJCehU";

  final client = StreamChatClient(
    'b4re75w9bucu',
    logLevel: Level.OFF
  );

  await client.connectUser(
    User(
      id: userid,
      name: "Hayato Yu",
      image: 'https://getstream.io/random_svg/?name=John',
    ),
    userToken
  );

  final channel = client.channel(
    'messaging',
    id: 'godevs',
    extraData: {
      'name' : 'Flutter devs'
    }
  );

  final message = Message(
    text: 'test test test',
    extraData: const {
      'customField' : '123'
    }
  );

  await channel.watch();
  await channel.sendMessage(message);

  runApp(
    MyApp(
      client: client,
      channel: channel
    )
  );
}

class MyApp extends StatelessWidget {
  
  const MyApp(
    {
      super.key,
      required this.client,
      required this.channel
    }
  );

  final StreamChatClient client;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('fr'),
        Locale('it'),
        Locale('es'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW')
      ],
      localizationsDelegates: GlobalStreamChatLocalizations.delegates,
      builder: (context, widget) => StreamChat(
        client: client,
        child: widget,
      ),
      home: StreamChannel(
        channel: channel,
        child: const ResponsiveChat(),
      ),
    );
  }
}

class ResponsiveChat extends StatelessWidget {
  const ResponsiveChat({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isMobile) {
          return ChannelListPage(
            onTap: (c) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return StreamChannel(
                      channel: c,
                      child: ChannelPage(
                        onBackPressed: (context) {
                          Navigator.of(
                            context,
                            rootNavigator: true
                          ).pop();
                        },
                      )
                    );
                  }
                )
              );
            },
          );
        }
        return SplitView();
      },
      breakpoints: const ScreenBreakpoints(
        desktop: 550, 
        tablet: 550, 
        watch: 300
      ),
    );
  }
}

class SplitView extends StatefulWidget {
  const SplitView({super.key});

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {

  Channel? selectedChannel;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
          child: ChannelListPage(
            onTap: (channel) {
              setState(() {
                selectedChannel = channel;
              });
            },
            selectedChannel: selectedChannel,
          ),
        ),
        Flexible(
          flex: 2,
          child: ClipPath(
            child: Scaffold(
              body: selectedChannel != null 
                ? StreamChannel(
                  key: ValueKey(selectedChannel!.cid),
                  channel: selectedChannel!,
                  child: const ChannelPage(),
                )
                : Center(
                  child: Text(
                    'Pick a channel to show the messages',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({
    super.key,
    this.onTap,
    this.selectedChannel,
  });

  final void Function(Channel)? onTap;
  final Channel? selectedChannel;

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {

  late final _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_('members', [StreamChat.of(context).currentUser!.id]),
    channelStateSort: const [SortOption('last_message_at')],
    limit: 20
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamChannelListView(
        controller: _listController,
        onChannelTap: widget.onTap,
        itemBuilder: (context, items, index, defaultWidget) {
          return defaultWidget.copyWith(
            selected: items[index] == widget.selectedChannel
          );
        }
      ),
    );
  }
}

class ChannelPage extends StatefulWidget {
  const ChannelPage({
    super.key,
    this.showBackButton = true,
    this.onBackPressed
  });

  final bool showBackButton;
  final void Function(BuildContext)? onBackPressed;

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {

  late final messageInputController = StreamMessageInputController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) => Navigator(
    onGenerateRoute: (settings) => MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: StreamChannelHeader(
          onBackPressed: widget.onBackPressed != null 
          ? () {
            widget.onBackPressed!(context);
          }
          : null,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamMessageListView(
                onMessageSwiped: (CurrentPlatform.isAndroid || CurrentPlatform.isIos) ? reply : null,
                threadBuilder: (context, parent) {
                  return ThreadPage(
                    parent: parent!
                  );
                },
                messageBuilder: (context, details, messages, defaultWidget) {
                  return defaultWidget.copyWith(
                    onReplyTap: reply,
                  );
                },
              ),
            ),
            StreamMessageInput(
              onQuotedMessageCleared: messageInputController.clearQuotedMessage,
              focusNode: focusNode,
              messageInputController: messageInputController,
            ),
          ],
        ),
      ),
    ),
  );

  void reply(Message message) {
    messageInputController.quotedMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {focusNode.requestFocus();});
  }

  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}

class ThreadPage extends StatelessWidget {
  const ThreadPage({super.key, required this.parent});

  final Message parent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamThreadHeader(
        parent: parent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamMessageListView(
              parentMessage: parent,
            ),
          ),
          StreamMessageInput(
            messageInputController: StreamMessageInputController(
              message: Message(parentId: parent.id)
            ),
          )
        ],
      ),
    );
  }
}