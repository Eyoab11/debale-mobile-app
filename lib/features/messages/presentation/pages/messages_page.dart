import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesPage extends ConsumerWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Search messages
            },
          ),
        ],
      ),
      body: _buildMessagesList(context),
    );
  }

  Widget _buildMessagesList(BuildContext context) {
    // Mock data for demonstration
    final mockMessages = [
      {
        'name': 'Abebe Kebede',
        'lastMessage': 'Hi! Is the room still available?',
        'time': '2 min ago',
        'unread': true,
        'avatar': 'assets/images/avatar1.jpg',
      },
      {
        'name': 'Kebede Alemu',
        'lastMessage': 'Thank you for your interest. Yes, it is.',
        'time': '1 hour ago',
        'unread': false,
        'avatar': 'assets/images/avatar2.jpg',
      },
      {
        'name': 'Tigist Haile',
        'lastMessage': 'Can we meet tomorrow to see the room?',
        'time': '3 hours ago',
        'unread': true,
        'avatar': 'assets/images/avatar3.jpg',
      },
      {
        'name': 'Yohannes Tesfaye',
        'lastMessage': 'Perfect! Looking forward to meeting you.',
        'time': '1 day ago',
        'unread': false,
        'avatar': 'assets/images/avatar4.jpg',
      },
    ];

    if (mockMessages.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No messages yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Start connecting with roommates and landlords',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: mockMessages.length,
      itemBuilder: (context, index) {
        final message = mockMessages[index];
        final name = message['name'] as String;
        final lastMessage = message['lastMessage'] as String;
        final time = message['time'] as String;
        final unread = message['unread'] as bool;
        
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: unread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Expanded(
                child: Text(
                  lastMessage,
                  style: TextStyle(
                    fontWeight: unread ? FontWeight.w500 : FontWeight.normal,
                    color: unread ? Colors.black87 : Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (unread)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          onTap: () {
            // TODO: Navigate to chat page
            _showChatPage(context, name);
          },
        );
      },
    );
  }

  void _showChatPage(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(recipientName: name),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String recipientName;

  const ChatPage({
    super.key,
    required this.recipientName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add some mock messages
    _messages.addAll([
      ChatMessage(
        text: 'Hi! Is the room still available?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        text: 'Yes, it is! When would you like to see it?',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
    ]);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipientName),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // TODO: Make call
            },
          ),
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {
              // TODO: Make video call
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isMe ? Colors.green[600] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isMe ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            onPressed: _sendMessage,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: _messageController.text.trim(),
            isMe: true,
            timestamp: DateTime.now(),
          ),
        );
      });
      _messageController.clear();
    }
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
} 