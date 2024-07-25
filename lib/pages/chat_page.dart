import 'package:flutter/material.dart';
import 'package:virtuallearningapp/components/user_tile.dart';
import 'package:virtuallearningapp/pages/chat_screen_page.dart';
import 'package:virtuallearningapp/services/auth_services.dart';
import 'package:virtuallearningapp/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  // Chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      appBar: AppBar(
        title: const Center(child: Text(" C H A T   S C R E E N ")),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: _buildUserList(),
    );
  }

  // Build a list of users
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // Loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        // Process user data
        List<Map<String, dynamic>> userDataList = snapshot.data!;
        String currentUserID = _authService.getCurrentUser()!.uid;

        return FutureBuilder<List<Map<String, dynamic>>>(
          future: _sortUsersByLastMessageTimestamp(userDataList, currentUserID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return const Text("Error");
            }

            List<Map<String, dynamic>> sortedUserDataList = snapshot.data!;

            return ListView(
              children: sortedUserDataList
                  .map<Widget>((userData) => _buildUserListItem(userData, context))
                  .toList(),
            );
          },
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _sortUsersByLastMessageTimestamp(
      List<Map<String, dynamic>> userDataList, String currentUserID) async {
    List<Map<String, dynamic>> sortedUserDataList = [];

    for (var userData in userDataList) {
      if (userData['uid'] != currentUserID) {
        Timestamp? lastMessageTimestamp =
            await _chatService.getLastMessageTimestamp(currentUserID, userData['uid']);
        userData['lastMessageTimestamp'] = lastMessageTimestamp ?? Timestamp(0, 0);
        sortedUserDataList.add(userData);
      }
    }

    sortedUserDataList.sort((a, b) {
      Timestamp timestampA = a['lastMessageTimestamp'];
      Timestamp timestampB = b['lastMessageTimestamp'];
      return timestampB.compareTo(timestampA); // Sort in descending order
    });

    return sortedUserDataList;
  }

  // Build individual list tile for user
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    // Display all users except current user
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Profiles')
            .doc(userData['uid'])
            .get(),
        builder: (context, snapshot) {
          String displayName;
          if (snapshot.connectionState == ConnectionState.waiting) {
            displayName = 'Loading...';
          } else if (snapshot.hasError) {
            displayName = userData['email'];
          } else if (snapshot.hasData && snapshot.data!.exists) {
            var profileData = snapshot.data!.data() as Map<String, dynamic>;
            displayName = profileData.containsKey('fullName')
                ? profileData['fullName']
                : userData['email'];
          } else {
            displayName = userData['email'];
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chat_rooms')
                .doc(_chatService.getChatRoomID(_authService.getCurrentUser()!.uid, userData['uid']))
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .limit(1)
                .snapshots(),
            builder: (context, snapshot) {
              String lastMessage = '';
              int unreadCount = 0;

              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                var lastMsgDoc = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                lastMessage = lastMsgDoc['message'];
                unreadCount = snapshot.data!.docs
                    .where((doc) => !doc['isRead'] && doc['receiverID'] == _authService.getCurrentUser()!.uid)
                    .length;
              }

              return UserTile(
                text: displayName,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreenPage(
                        receiverEmail: userData['email'],
                        receiverID: userData['uid'],
                      ),
                    ),
                  );
                },
                lastMessage: lastMessage,
                unreadCount: unreadCount,
              );
            },
          );
        },
      );
    } else {
      return Container();
    }
  }
}
