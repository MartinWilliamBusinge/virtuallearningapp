import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:virtuallearningapp/components/my_textfield.dart';
import 'package:virtuallearningapp/services/auth_services.dart';
import 'package:virtuallearningapp/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreenPage extends StatefulWidget {
  const ChatScreenPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  final String receiverEmail;
  final String receiverID;

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  // for textfield focus
  FocusNode myFocusNode = FocusNode();

  // chat and authentication services
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // scroll controller
  final ScrollController _scrollController = ScrollController();

  String? receiverName;
  bool isLoading = true;

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 300),
          () => scrollDown(),
        );
      }
    });

    _fetchReceiverName();
    _listenForNewMessages();
  }

  Future<void> _fetchReceiverName() async {
    var doc = await FirebaseFirestore.instance
        .collection('Profiles')
        .doc(widget.receiverID)
        .get();

    if (doc.exists && doc.data()!.containsKey('fullName')) {
      setState(() {
        receiverName = doc['fullName'];
        isLoading = false;
      });
    } else {
      setState(() {
        receiverName = widget.receiverEmail;
        isLoading = false;
      });
    }
  }

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverID, _messageController.text);
      _messageController.clear();
      scrollDown();
    }
  }

  Widget _buildMessageList() {
    User? currentUser = _authService.getCurrentUser();
    if (currentUser == null) {
      return const Text("User not authenticated");
    }

    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderID, widget.receiverID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading....");
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text("No messages yet.");
        }
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isSentByMe = data['senderID'] == _authService.getCurrentUser()?.uid;

    DateTime timestamp = (data['timestamp'] as Timestamp).toDate();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(timestamp);

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              data["message"] ?? 'No message', // Handle missing message field
              style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 5),
            Text(
              formattedDate,
              style: TextStyle(
                color: isSentByMe ? Colors.white70 : Colors.black54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
              focusNode: myFocusNode,
              // Ensure `suffixIcon` is not used if it's not defined in `MyTextField`
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _listenForNewMessages() {
    final String currentUserID = _authService.getCurrentUser()!.uid;
    _chatService.getNewMessagesStream(currentUserID).listen((snapshot) {
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['receiverID'] == currentUserID && !data['isRead']) {
          _showNotification(data['message']);
        }
      }
    });
  }

  Future<void> _showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'new_message_channel', // id
      'New Messages', // title
      channelDescription: 'Notification channel for new messages',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, // notification id
      'New Message',
      message,
      platformChannelSpecifics,
      payload: 'New Message Payload',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isLoading
            ? const CircularProgressIndicator()
            : Center(child: Text(receiverName ?? widget.receiverEmail)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }
}

// Initialize local notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
