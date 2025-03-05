import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUsers(reset: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        userProvider.fetchUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Centers the title horizontally
        backgroundColor: Colors.lightBlue[50], // Optional: Change AppBar background color
      ),

      backgroundColor: Colors.lightBlue[50], // Sky blue background
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Users',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // Rounded corners
                ),
                filled: true, // Enables background color
                fillColor: Colors.white,
              ),
              onChanged: (query) => setState(() => _searchQuery = query.toLowerCase()),
            ),
          ),
          SwitchListTile(
            title: Text("Show Users in Grid View", style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            value: userProvider.isGridView,
            onChanged: (value) => userProvider.toggleView(),
          ),
          Expanded(
            child: userProvider.isLoading && userProvider.users.isEmpty
                ? Center(child: CircularProgressIndicator())
                : userProvider.hasError
                ? Center(child: Text('Failed to fetch users'))
                : _buildUserList(userProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList(UserProvider userProvider) {
    final filteredUsers = userProvider.users
        .where((user) =>
    user.firstName.toLowerCase().contains(_searchQuery) ||
        user.lastName.toLowerCase().contains(_searchQuery))
        .toList();

    return userProvider.isGridView
        ? GridView.builder(
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) => _buildUserItem(filteredUsers[index]),
    )
        : ListView.builder(
      controller: _scrollController,
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) => _buildUserItem(filteredUsers[index]),
    );
  }

  Widget _buildUserItem(User user) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.picture)),
      title: Text('${user.title} ${user.firstName} ${user.lastName}'),
      subtitle: Text('ID: ${user.id}'),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)),
      ),
    );
  }
}

