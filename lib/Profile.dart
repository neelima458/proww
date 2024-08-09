import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 229, 247, 235),
            ),
            height: 100,
            child: Text(
              "P R O F I L E",
              style: TextStyle(
                color: Colors.green,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            width: double.infinity,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),

                  // Profile Image and Information
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                              AssetImage('assets/images/cat.png'),
                            ),
                            Positioned(
                              bottom: -10,
                              right: -10,
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Implement profile picture edit functionality
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: ListTile(
                          leading: Icon(Icons.person, color: Colors.green),
                          title: Text(
                            'Neelima Paul',
                            style: TextStyle(color: Colors.green),
                          ),
                          subtitle: Text(
                            '20051079@kiit.ac.in',
                            style: TextStyle(color: Colors.green),
                          ),
                          onTap: () {
                            _showEditBottomSheet(
                                context, 'Name', 'Neelima Paul');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Stock Preferences Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stock Preferences',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading:
                        Icon(Icons.trending_up, color: Colors.green),
                        title: Text('Favorite Stocks',
                            style: TextStyle(color: Colors.green)),
                        subtitle: Text('Click to edit',
                            style: TextStyle(color: Colors.green)),
                        onTap: () {
                          _showEditBottomSheet(context, 'Favorite Stocks',
                              'AAPL, TSLA, GOOG');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications_active,
                            color: Colors.green),
                        title: Text('Notification Preferences',
                            style: TextStyle(color: Colors.green)),
                        subtitle: Text('Click to edit',
                            style: TextStyle(color: Colors.green)),
                        onTap: () {
                          _showEditBottomSheet(context,
                              'Notification Preferences', 'Daily Alerts');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Recent Activity Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Activity',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // Add widgets to display user's recent activity in the app
                      // Example: ListTile(title: Text('Bought AAPL at \$150')),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Chip(
                              label: Text(
                                'Bought AAPL at \$150',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                            ),
                            SizedBox(width: 10),
                            Chip(
                              label: Text(
                                'Sold TSLA at \$700',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Achievements Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Achievements and Badges',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Chip(
                              label: Text(
                                'Top Investor',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.amber,
                            ),
                            SizedBox(width: 10),
                            Chip(
                              label: Text(
                                'Market Guru',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Logout Button
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement logout functionality
                      },
                      style: ElevatedButton.styleFrom(

                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Logout'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditBottomSheet(
      BuildContext context, String title, String initialValue) {
    TextEditingController controller =
    TextEditingController(text: initialValue);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit $title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'New $title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Implement save functionality
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
