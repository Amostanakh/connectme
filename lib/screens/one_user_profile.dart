import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final Map<String, String> peer;

  UserProfilePage({required this.peer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile: ${peer['name']}'),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    AssetImage('assets/logo.png'), // Replace with actual image
              ),
              SizedBox(height: 20),

              // Name
              Text(
                peer['name']!,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),

              // Divider
              Divider(
                thickness: 2,
                color: Colors.blueAccent,
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(height: 20),

              // Profile Details Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Age
                      _buildProfileDetail(label: 'Age', value: peer['age']!),

                      Divider(thickness: 1, color: Colors.grey[300]),

                      // Address
                      _buildProfileDetail(
                          label: 'Address', value: peer['address']!),

                      Divider(thickness: 1, color: Colors.grey[300]),

                      // Occupation
                      _buildProfileDetail(
                          label: 'Occupation', value: peer['occupation']!),

                      Divider(thickness: 1, color: Colors.grey[300]),

                      // Email
                      _buildProfileDetail(
                          label: 'Email', value: peer['email']!),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 40),

              // Add Friend Button
              ElevatedButton(
                onPressed: () {
                  // Handle adding friend logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Friend request sent to ${peer['name']}'),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: Text('Call', style: TextStyle(fontSize: 18)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build profile details
  Widget _buildProfileDetail({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label + ':',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[900],
            ),
          ),
        ],
      ),
    );
  }
}
