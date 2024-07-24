import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so that the keyboard can show up
        // then calculate the amount of remaining space
        // scroll down
        Future.delayed(
          const Duration(milliseconds: 300),
          () => scrollDown(),
        );
      }
    });

    _fetchReceiverName();
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

  // send message
  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // send
      await _chatService.sendMessage(widget.receiverID, _messageController.text);
      // clear
      _messageController.clear();
      // scroll down to the latest message
      scrollDown();
    }
  }

  Widget _buildMessageList() {
    User? currentUser = _authService.getCurrentUser();
    if (currentUser == null) {
      return const Text("User not authenticated");
    }
    // MIGHT NEED SOME ADJUSTMENTS KEEP IN MIND
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading....");
        }
        // check if snapshot has data
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text("No messages yet.");
        }
        // return List View
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isSentByMe = data['senderID'] == _authService.getCurrentUser()?.uid;

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          data["message"],
          style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  // build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          // textfield should take up most of the space
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
              focusNode: myFocusNode,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
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
          // display all messages
          Expanded(
            child: _buildMessageList(),
          ),
          // user input
          _buildUserInput(),
        ],
      ),
    );
  }
}
