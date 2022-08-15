import 'package:flutter/cupertino.dart';

class DatePickItem extends StatelessWidget {
  const DatePickItem({ Key? key, required this.children }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0
          )
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}