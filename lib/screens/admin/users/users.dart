import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twinzy/models/user.dart';
import 'package:twinzy/screens/admin/users/widgets.dart';
import 'package:twinzy/theme/colors.dart';

class UsersAdmin extends StatefulWidget {
  const UsersAdmin({Key? key}) : super(key: key);

  @override
  State<UsersAdmin> createState() => _UsersAdminState();
}

class _UsersAdminState extends State<UsersAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            List<User> allUsers = [];
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: primary,
                  color: Colors.white,
                ),
              );
            }
            final users = snapshot.data!.docs;
            for (var user in users) {
              final userFirstName = user.get('firstName');
              final userLastName = user.get('lastName');
              final userId = user.get('id');
              final userPhone = user.get('phone');
              final userEmail = user.get('email');
              final userPassword = user.get('password');
              final oneUser = User(
                phone: userPhone,
                id: userId,
                firstName: userFirstName,
                lastName: userLastName,
                password: userPassword,
                email: userEmail,
              );
              allUsers.add(oneUser);
            }
            return gridUsers(
              usersList: allUsers,
              context: context,
              setState: setState,
            );
          }),
    );
  }
}
