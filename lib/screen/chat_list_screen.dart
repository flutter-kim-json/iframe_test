import 'dart:html' as html;

import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    html.window.onMessage.listen((event) {
      final data = (event as html.MessageEvent).data;
      print('onMessage');
      print(data['sender']);
      print(data['message']);
      setState(() {
        message = data['message'];
      });
    });
    html.window.addEventListener('message', (event) {
      final data = (event as html.MessageEvent).data;
      print('addEventListener');
      print(data['sender']);
      print(data['message']);
      setState(() {
        message = data['message'];
      });
    });
    super.initState();
  }

  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('링커리어 채팅 기능'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                // window.onMessage.listen((event) {
                //   print(event);
                // });

                html.window.parent?.postMessage('hello javascript', '*');

                html.window.postMessage('message test', '*');
              },
              child: const Text('브릿지 테스트'))
        ],
      ),
    );
  }
}
