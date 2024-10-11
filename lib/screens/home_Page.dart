import 'package:connectme/screens/one_user_profile.dart';
import 'package:connectme/screens/vedio_call_page.dart';
import 'package:flutter/material.dart';

class FriendPeersPage extends StatefulWidget {
  @override
  _FriendPeersPageState createState() => _FriendPeersPageState();
}

class _FriendPeersPageState extends State<FriendPeersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peers & Friends'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Peers'), // First tab for Peers
            Tab(text: 'Friends'), // Second tab for Friends
          ],
          indicatorColor: Colors.white, // Indicator color for active tab
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PeersPage(), // Content for Peers tab
          FriendsPage(), // Content for Friends tab
        ],
      ),
    );
  }
}

class PeersPage extends StatelessWidget {
  // Mock data for peers' names and details
  final List<Map<String, String>> peers = [
    {
      'name': 'John Doe',
      'age': '25',
      'address': '123 Main Street, New York',
      'occupation': 'Software Engineer',
      'email': 'johndoe@example.com',
    },
    {
      'name': 'Jane Smith',
      'age': '30',
      'address': '456 Elm Street, Los Angeles',
      'occupation': 'Product Manager',
      'email': 'janesmith@example.com',
    },
    {
      'name': 'Alex Baker',
      'age': '28',
      'address': '789 Pine Avenue, Chicago',
      'occupation': 'Graphic Designer',
      'email': 'alexbaker@example.com',
    },
    {
      'name': 'Emily Johnson',
      'age': '26',
      'address': '101 Oak Street, Houston',
      'occupation': 'Data Scientist',
      'email': 'emilyjohnson@example.com',
    },
    {
      'name': 'Chris Martin',
      'age': '32',
      'address': '202 Cedar Drive, Miami',
      'occupation': 'Marketing Specialist',
      'email': 'chrismartin@example.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text(
            'People You May Know',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: peers.length,
              itemBuilder: (context, index) {
                final peer = peers[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/logo.png'), // Replace with actual image
                    ),
                    title: Text(peer['name']!),
                    subtitle: Text(peer['occupation']!),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Handle friend request logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Friend request sent to ${peer['name']}')),
                        );
                      },
                      child: Text('Add Friend'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onTap: () {
                      // Navigate to UserProfilePage and pass peer details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfilePage(peer: peer),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FriendsPage extends StatelessWidget {
  // Mock data for friends' names and details
  final List<Map<String, String>> friends = [
    {
      'name': 'John Doe',
      'age': '25',
      'address': '123 Main Street, New York',
      'occupation': 'Software Engineer',
      'email': 'johndoe@example.com',
    },
    {
      'name': 'Jane Smith',
      'age': '30',
      'address': '456 Elm Street, Los Angeles',
      'occupation': 'Product Manager',
      'email': 'janesmith@example.com',
    },
    {
      'name': 'Alex Baker',
      'age': '28',
      'address': '789 Pine Avenue, Chicago',
      'occupation': 'Graphic Designer',
      'email': 'alexbaker@example.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text(
            'Your Friends',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/logo.png'), // Replace with actual image
                    ),
                    title: Text(friend['name']!),
                    subtitle: Text(friend['occupation']!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.video_call, color: Colors.green),
                          onPressed: () {
                            // Navigate to the VideoCallPage and pass the friend's name
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VideoCallPage(callerName: friend['name']!),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Starting video call with ${friend['name']}...'),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.person, color: Colors.blue),
                          onPressed: () {
                            // Navigate to UserProfilePage and pass friend details
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserProfilePage(peer: friend),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
