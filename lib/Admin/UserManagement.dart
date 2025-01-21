// import 'package:bilu2/provider/userProvider.dart';
// import 'package:flutter/material.dart';  
// import 'package:provider/provider.dart';  
// import 'package:cloud_firestore/cloud_firestore.dart';  
  
// class UserManagementPage extends StatefulWidget {  
//   @override  
//   _UserManagementPageState createState() => _UserManagementPageState();  
// }  
  
// class _UserManagementPageState extends State<UserManagementPage> {  
//   final TextEditingController _usernameController = TextEditingController();  
//   final TextEditingController _nameController = TextEditingController();  
//   final TextEditingController _roleController = TextEditingController();  
//   final TextEditingController _classNameController = TextEditingController();  
//   final TextEditingController _photoUrlController = TextEditingController();  
  
//   String? _editingUserId;  
  
//   @override  
//   void initState() {  
//     super.initState();  
//     Provider.of<UserProvider>(context, listen: false).fetchAllStudents();  
//   }  
  
//   void _showAddUserDialog() {  
//     _usernameController.clear();  
//     _nameController.clear();  
//     _roleController.clear();  
//     _classNameController.clear();  
//     _photoUrlController.clear();  
//     _editingUserId = null;  
  
//     showDialog(  
//       context: context,  
//       builder: (BuildContext context) {  
//         return AlertDialog(  
//           title: Text('Add New User'),  
//           content: _buildUserForm(),  
//           actions: <Widget>[  
//             TextButton(  
//               child: Text('Cancel'),  
//               onPressed: () {  
//                 Navigator.of(context).pop();  
//               },  
//             ),  
//             TextButton(  
//               child: Text('Add'),  
//               onPressed: () {  
//                 _addOrUpdateUser();  
//                 Navigator.of(context).pop();  
//               },  
//             ),  
//           ],  
//         );  
//       },  
//     );  
//   }  
  
//   void _showEditUserDialog(String userId) {  
//     final userProvider = Provider.of<UserProvider>(context, listen: false);  
//     final user = userProvider.students.firstWhere((user) => user['id'] == userId);  
  
//     _usernameController.text = user['username'] ?? '';  
//     _nameController.text = user['name'] ?? '';  
//     _roleController.text = user['role'] ?? '';  
//     _classNameController.text = user['className'] ?? '';  
//     _photoUrlController.text = user['photoUrl'] ?? '';  
//     _editingUserId = userId;  
  
//     showDialog(  
//       context: context,  
//       builder: (BuildContext context) {  
//         return AlertDialog(  
//           title: Text('Edit User'),  
//           content: _buildUserForm(),  
//           actions: <Widget>[  
//             TextButton(  
//               child: Text('Cancel'),  
//               onPressed: () {  
//                 Navigator.of(context).pop();  
//               },  
//             ),  
//             TextButton(  
//               child: Text('Update'),  
//               onPressed: () {  
//                 _addOrUpdateUser();  
//                 Navigator.of(context).pop();  
//               },  
//             ),  
//           ],  
//         );  
//       },  
//     );  
//   }  
  
//   Widget _buildUserForm() {  
//     return SingleChildScrollView(  
//       child: Column(  
//         mainAxisSize: MainAxisSize.min,  
//         children: <Widget>[  
//           TextField(  
//             controller: _usernameController,  
//             decoration: InputDecoration(labelText: 'Username'),  
//           ),  
//           TextField(  
//             controller: _nameController,  
//             decoration: InputDecoration(labelText: 'Name'),  
//           ),  
//           TextField(  
//             controller: _roleController,  
//             decoration: InputDecoration(labelText: 'Role'),  
//           ),  
//           TextField(  
//             controller: _classNameController,  
//             decoration: InputDecoration(labelText: 'Class Name'),  
//           ),  
//           TextField(  
//             controller: _photoUrlController,  
//             decoration: InputDecoration(labelText: 'Photo URL'),  
//           ),  
//         ],  
//       ),  
//     );  
//   }  
  
//   void _addOrUpdateUser() async {  
//     final userProvider = Provider.of<UserProvider>(context, listen: false);  
//     final username = _usernameController.text;  
//     final name = _nameController.text;  
//     final role = _roleController.text;  
//     final className = _classNameController.text;  
//     final photoUrl = _photoUrlController.text;  
  
//     if (_editingUserId != null) {  
//       // Update existing user  
//       await FirebaseFirestore.instance.collection('users').doc(_editingUserId).update({  
//         'username': username,  
//         'name': name,  
//         'role': role,  
//         'className': className,  
//         'photoUrl': photoUrl,  
//       });  
//     } else {  
//       // Add new user  
//       await FirebaseFirestore.instance.collection('users').add({  
//         'username': username,  
//         'name': name,  
//         'role': role,  
//         'className': className,  
//         'photoUrl': photoUrl,  
//         'bill': [],  
//         'attendance': [],  
//         'savings': {'history': []},  
//       });  
//     }  
  
//     userProvider.fetchAllStudents();  
//   }  
  
//   void _deleteUser(String userId) {  
//     showDialog(  
//       context: context,  
//       builder: (BuildContext context) {  
//         return AlertDialog(  
//           title: Text('Confirm Delete'),  
//           content: Text('Are you sure you want to delete this user?'),  
//           actions: <Widget>[  
//             TextButton(  
//               child: Text('Cancel'),  
//               onPressed: () {  
//                 Navigator.of(context).pop();  
//               },  
//             ),  
//             TextButton(  
//               child: Text('Delete'),  
//               onPressed: () async {  
//                 await FirebaseFirestore.instance.collection('users').doc(userId).delete();  
//                 Provider.of<UserProvider>(context, listen: false).fetchAllStudents();  
//                 Navigator.of(context).pop();  
//               },  
//             ),  
//           ],  
//         );  
//       },  
//     );  
//   }  
  
//   @override  
//   Widget build(BuildContext context) {  
//     final userProvider = Provider.of<UserProvider>(context);  
  
//     return Scaffold(  
//       appBar: AppBar(  
//         title: Text('User Management'),  
//       ),  
//       body: userProvider.isLoading  
//           ? Center(child: CircularProgressIndicator())  
//           : ListView.builder(  
//               itemCount: userProvider.students.length,  
//               itemBuilder: (context, index) {  
//                 final user = userProvider.students[index];  
//                 return ListTile(  
//                   leading: CircleAvatar(  
//                     backgroundImage: NetworkImage(user['photoUrl'] ?? ''),  
//                   ),  
//                   title: Text(user['name']),  
//                   subtitle: Text(user['role']),  
//                   trailing: Row(  
//                     mainAxisSize: MainAxisSize.min,  
//                     children: [  
//                       IconButton(  
//                         icon: Icon(Icons.edit),  
//                         onPressed: () => _showEditUserDialog(user['id']),  
//                       ),  
//                       IconButton(  
//                         icon: Icon(Icons.delete),  
//                         onPressed: () => _deleteUser(user['id']),  
//                       ),  
//                     ],  
//                   ),  
//                 );  
//               },  
//             ),  
//       floatingActionButton: FloatingActionButton(  
//         onPressed: _showAddUserDialog,  
//         child: Icon(Icons.add),  
//       ),  
//     );  
//   }  
// }  


// Stabil


// import 'package:bilu2/provider/UserManagementProvider.dart';  
// import 'package:bilu2/theme.dart';      
// import 'package:flutter/material.dart';        
// import 'package:provider/provider.dart';        
  
// class UserManagement extends StatefulWidget {        
//   @override        
//   _UserManagementState createState() => _UserManagementState();        
// }        
  
// class _UserManagementState extends State<UserManagement> {        
//   final TextEditingController _nameController = TextEditingController();        
//   final TextEditingController _classNameController = TextEditingController();        
//   final TextEditingController _photoUrlController = TextEditingController();        
//   String _selectedRole = 'student'; // Default role        
  
//   @override        
//   void initState() {        
//     super.initState();        
//     // Fetch all users when the widget is initialized      
//     Provider.of<UserManagementProvider>(context, listen: false).fetchAllUsers();        
//   }        
  
//   void _showEditUserDialog(String userId, Map<String, dynamic> user) {        
//     _nameController.text = user['name'] ?? '';        
//     _classNameController.text = user['className'] ?? '';        
//     _photoUrlController.text = user['photoUrl'] ?? '';        
//     _selectedRole = user['role'] ?? 'student';        
  
//     showDialog(        
//       context: context,        
//       builder: (BuildContext context) {        
//         return AlertDialog(        
//           title: Text('Edit User'),        
//           content: _buildUserForm(),        
//           actions: <Widget>[        
//             TextButton(        
//               child: Text('Cancel'),        
//               onPressed: () {        
//                 Navigator.of(context).pop();        
//               },        
//             ),        
//             TextButton(        
//               child: Text('Update'),        
//               onPressed: () {        
//                 _updateUser(userId);        
//                 Navigator.of(context).pop();        
//               },        
//             ),        
//           ],        
//         );        
//       },        
//     );        
//   }        
  
//   Widget _buildUserForm() {        
//     return SingleChildScrollView(        
//       child: Column(        
//         mainAxisSize: MainAxisSize.min,        
//         children: <Widget>[        
//           DropdownButtonFormField<String>(        
//             value: _selectedRole,        
//             decoration: InputDecoration(labelText: 'Role'),        
//             items: ['student', 'admin'].map((String role) {        
//               return DropdownMenuItem<String>(        
//                 value: role,        
//                 child: Text(role),        
//               );        
//             }).toList(),        
//             onChanged: (String? value) {        
//               setState(() {        
//                 _selectedRole = value!;        
//                 // Clear the class name and photo URL fields when switching to admin        
//                 if (_selectedRole == 'admin') {        
//                   _classNameController.clear();        
//                   _photoUrlController.clear();        
//                 }        
//               });        
//             },        
//           ),        
//           TextField(        
//             controller: _nameController,        
//             decoration: InputDecoration(labelText: 'Name'),        
//           ),        
//           if (_selectedRole == 'student') ...[        
//             TextField(        
//               controller: _classNameController,        
//               decoration: InputDecoration(labelText: 'Class Name'),        
//             ),        
//             TextField(        
//               controller: _photoUrlController,        
//               decoration: InputDecoration(labelText: 'Photo URL'),        
//             ),        
//           ],        
//         ],        
//       ),        
//     );        
//   }        
  
//   void _updateUser(String userId) async {        
//     final userManagementProvider = Provider.of<UserManagementProvider>(context, listen: false);        
//     final name = _nameController.text;        
//     final role = _selectedRole;        
//     final className = _classNameController.text;        
//     final photoUrl = _photoUrlController.text;        
  
//     // Validation: Check if required fields are empty        
//     if (name.isEmpty || role.isEmpty) {        
//       ScaffoldMessenger.of(context).showSnackBar(        
//         SnackBar(        
//           content: Text('Name and Role are required!'),        
//           backgroundColor: Colors.red,        
//         ),        
//       );        
//       return;        
//     }        
  
//     // Additional validation for students        
//     if (role == 'student' && (className.isEmpty || photoUrl.isEmpty)) {        
//       ScaffoldMessenger.of(context).showSnackBar(        
//         SnackBar(        
//           content: Text('Class Name and Photo URL are required for students!'),        
//           backgroundColor: Colors.red,        
//         ),        
//       );        
//       return;        
//     }        
  
//     try {        
//       await userManagementProvider.updateUser(userId, name, role, className, photoUrl);        
//       ScaffoldMessenger.of(context).showSnackBar(        
//         SnackBar(        
//           content: Text('User updated successfully!'),        
//           backgroundColor: Colors.green,        
//         ),        
//       );        
//     } catch (e) {        
//       ScaffoldMessenger.of(context).showSnackBar(        
//         SnackBar(        
//           content: Text('Error updating user: $e'),        
//           backgroundColor: Colors.red,        
//         ),        
//       );        
//     }        
//   }        
  
//   void _deleteUser(String userId) {        
//     showDialog(        
//       context: context,        
//       builder: (BuildContext context) {        
//         return AlertDialog(        
//           title: Text('Confirm Delete'),        
//           content: Text('Are you sure you want to delete this user?'),        
//           actions: <Widget>[        
//             TextButton(        
//               child: Text('Cancel'),        
//               onPressed: () {        
//                 Navigator.of(context).pop();        
//               },        
//             ),        
//             TextButton(        
//               child: Text('Delete'),        
//               onPressed: () async {        
//                 final userManagementProvider = Provider.of<UserManagementProvider>(context, listen: false);        
//                 try {        
//                   await userManagementProvider.deleteUser(userId);        
//                   ScaffoldMessenger.of(context).showSnackBar(        
//                     SnackBar(        
//                       content: Text('User deleted successfully!'),        
//                       backgroundColor: Colors.green,        
//                     ),        
//                   );        
//                 } catch (e) {        
//                   ScaffoldMessenger.of(context).showSnackBar(        
//                     SnackBar(        
//                       content: Text('Error deleting user: $e'),        
//                       backgroundColor: Colors.red,        
//                     ),        
//                   );        
//                 }        
//                 Navigator.of(context).pop();        
//               },        
//             ),        
//           ],        
//         );        
//       },        
//     );        
//   }        
  
//   @override        
//   Widget build(BuildContext context) {        
//     final userManagementProvider = Provider.of<UserManagementProvider>(context);        
  
//     return Scaffold(        
//       appBar: AppBar(        
//         title: Text('All Users'),        
//       ),        
//       body: userManagementProvider.isLoading        
//           ? Center(child: CircularProgressIndicator())        
//           : ListView.builder(        
//               itemCount: userManagementProvider.users.length,        
//               itemBuilder: (context, index) {        
//                 final user = userManagementProvider.users[index];       
//                 return ListTile(        
//                   leading: CircleAvatar(        
//                     backgroundImage: NetworkImage(user['photoUrl'] ?? ''),        
//                     child: user['photoUrl'] == null        
//                         ? Icon(Icons.person, color: Colors.white)        
//                         : null,        
//                   ),        
//                   title: Text(user['name'] ?? 'No Name'),        
//                   subtitle: Column(        
//                     crossAxisAlignment: CrossAxisAlignment.start,        
//                     children: [        
//                       Text('Role: ${user['role'] ?? 'No Role'}'),        
//                       if (user['role'] == 'student')        
//                         Text('Class: ${user['className'] ?? 'No Class'}'),        
//                     ],        
//                   ),        
//                   trailing: Row(        
//                     mainAxisSize: MainAxisSize.min,        
//                     children: [        
//                       IconButton(        
//                         icon: Icon(Icons.edit),        
//                         onPressed: () => _showEditUserDialog(user['id'], user),        
//                       ),        
//                       IconButton(        
//                         icon: Icon(Icons.delete),        
//                         onPressed: () => _deleteUser(user['id']),        
//                       ),        
//                     ],        
//                   ),        
//                 );        
//               },        
//             ),        
//     );        
//   }        
// }        

import 'package:bilu2/provider/UserManagementProvider.dart';        
import 'package:bilu2/theme.dart';            
import 'package:flutter/material.dart';              
import 'package:provider/provider.dart';              
      
class UserManagement extends StatefulWidget {              
  @override              
  _UserManagementState createState() => _UserManagementState();              
}              
      
class _UserManagementState extends State<UserManagement> {              
  final TextEditingController _nameController = TextEditingController();              
  final TextEditingController _classNameController = TextEditingController();              
  final TextEditingController _photoUrlController = TextEditingController();              
  final TextEditingController _usernameController = TextEditingController(); // New controller for username    
  String _selectedRole = ''; // Default role is empty              
  bool _isExpanded = false; // To track the expansion state of the FAB              
   final TextEditingController _AddnameController = TextEditingController();              
  final TextEditingController _AddclassNameController = TextEditingController();              
  final TextEditingController _AddphotoUrlController = TextEditingController();              
  final TextEditingController _AddusernameController = TextEditingController(); // New controller for username    
  String _AddselectedRole = ''; // Default role is empty   
   
  @override              
  void initState() {              
    super.initState();              
    // Fetch all users when the widget is initialized            
    Provider.of<UserManagementProvider>(context, listen: false).fetchAllUsers();              
  }              
      
  void _showEditUserDialog(String userId, Map<String, dynamic> user) {              
    _nameController.text = user['name'] ?? '';              
    _classNameController.text = user['className'] ?? '';              
    _photoUrlController.text = user['photoUrl'] ?? '';              
    _usernameController.text = user['username'] ?? ''; // Set username for editing    
    _selectedRole = user['role'] ?? 'student';              
      
    showDialog(              
      context: context,              
      builder: (BuildContext context) {              
        return AlertDialog(              
          title: Text('Edit User'),              
          content: _buildUserForm(),              
          actions: <Widget>[              
            TextButton(              
              child: Text('Cancel'),              
              onPressed: () {           
                  _classNameController.clear();             
   _photoUrlController.clear();             
   _usernameController.clear();// New controller for username 
   _nameController.clear();    
                Navigator.of(context).pop();              
              },              
            ),              
            TextButton(              
              child: Text('Update'),              
              onPressed: () {              
                _updateUser(userId);              
                Navigator.of(context).pop();              
              },              
            ),              
          ],              
        );              
      },              
    );              
  }              
      
  Widget _buildUserForm() {              
    return SingleChildScrollView(              
      child: Column(              
        mainAxisSize: MainAxisSize.min,              
        children: <Widget>[              
          TextField(              
            controller: _nameController,              
            decoration: InputDecoration(labelText: 'Name'),              
          ),              
          if (_selectedRole == 'student') ...[              
            TextField(              
              controller: _classNameController,              
              decoration: InputDecoration(labelText: 'Class Name'),              
            ),              
            TextField(              
              controller: _photoUrlController,              
              decoration: InputDecoration(labelText: 'Photo URL'),              
            ),              
          ],    
          if (_selectedRole == 'admin') ...[ // Show username field for admin    
            TextField(    
              controller: _usernameController,    
              decoration: InputDecoration(labelText: 'Username'),    
            ),    
          ],              
        ],              
      ),              
    );              
  }     

  Widget _buildAddUserForm() {              
    return SingleChildScrollView(              
      child: Column(              
        mainAxisSize: MainAxisSize.min,              
        children: <Widget>[      
             TextField(              
            controller: _AddusernameController,              
            decoration: InputDecoration(labelText: 'Username'),              
          ),           
          TextField(              
            controller: _AddnameController,              
            decoration: InputDecoration(labelText: 'Name'),              
          ),              
          if (_selectedRole == 'student') ...[              
            TextField(              
              controller: _AddclassNameController,              
              decoration: InputDecoration(labelText: 'Class Name'),              
            ),              
            TextField(              
              controller: _AddphotoUrlController,              
              decoration: InputDecoration(labelText: 'Photo URL'),              
            ),              
          ],    
                    
        ],              
      ),              
    );              
  }              
      
  void _updateUser(String userId) async {              
    final userManagementProvider = Provider.of<UserManagementProvider>(context, listen: false);              
    final name = _nameController.text;              
    final role = _selectedRole;              
    final className = _classNameController.text;              
    final photoUrl = _photoUrlController.text;              
    final username = _usernameController.text; // Get username from the controller    
      
    // Validation: Check if required fields are empty              
    if (name.isEmpty || role.isEmpty) {              
      ScaffoldMessenger.of(context).showSnackBar(              
        SnackBar(              
          content: Text('Name and Role are required!'),              
          backgroundColor: Colors.red,              
        ),              
      );              
      return;              
    }              
      
    // Additional validation for students              
    if (role == 'student' && (className.isEmpty || photoUrl.isEmpty)) {              
      ScaffoldMessenger.of(context).showSnackBar(              
        SnackBar(              
          content: Text('Class Name and Photo URL are required for students!'),              
          backgroundColor: Colors.red,              
        ),              
      );              
      return;              
    }              
      
    // Additional validation for admins    
    if (role == 'admin' && username.isEmpty) {    
      ScaffoldMessenger.of(context).showSnackBar(    
        SnackBar(    
          content: Text('Username is required for admins!'),    
          backgroundColor: Colors.red,    
        ),    
      );    
      return;    
    }    
      
    try {              
      await userManagementProvider.updateUser(userId, name, role, className, photoUrl, username); // Pass username to update    
      ScaffoldMessenger.of(context).showSnackBar(              
        SnackBar(              
          content: Text('User updated successfully!'),              
          backgroundColor: Colors.green,              
        ),              
      );              
    } catch (e) {              
      ScaffoldMessenger.of(context).showSnackBar(              
        SnackBar(              
          content: Text('Error updating user: $e'),              
          backgroundColor: Colors.red,              
        ),              
      );              
    }              
  }              
      
  void _deleteUser(String userId) {              
    showDialog(              
      context: context,              
      builder: (BuildContext context) {              
        return AlertDialog(              
          title: Text('Confirm Delete'),              
          content: Text('Are you sure you want to delete this user?'),              
          actions: <Widget>[              
            TextButton(              
              child: Text('Cancel'),              
              onPressed: () {              
                Navigator.of(context).pop();              
              },              
            ),              
            TextButton(              
              child: Text('Delete'),              
              onPressed: () async {              
                final userManagementProvider = Provider.of<UserManagementProvider>(context, listen: false);              
                try {              
                  await userManagementProvider.deleteUser(userId);              
                  ScaffoldMessenger.of(context).showSnackBar(              
                    SnackBar(              
                      content: Text('User deleted successfully!'),              
                      backgroundColor: Colors.green,              
                    ),              
                  );              
                } catch (e) {              
                  ScaffoldMessenger.of(context).showSnackBar(              
                    SnackBar(              
                      content: Text('Error deleting user: $e'),              
                      backgroundColor: Colors.red,              
                    ),              
                  );              
                }              
                Navigator.of(context).pop();              
              },              
            ),              
          ],              
        );              
      },              
    );              
  }              
      
  void _showAddUserDialog(String role) {        
    _selectedRole = role; // Set the selected role based on the button pressed      
    showDialog(        
      context: context,        
      builder: (BuildContext context) {        
        return AlertDialog(        
          title: Text('Add User'),        
          content: _buildAddUserForm(),        
          actions: <Widget>[        
            TextButton(        
              child: Text('Cancel'),        
              onPressed: () {        
                 _AddnameController.clear();             
   _AddclassNameController.clear();             
   _AddphotoUrlController.clear();             
   _AddusernameController.clear();// New controller for username   
                Navigator.of(context).pop();        
              },        
            ),        
            TextButton(        
              child: Text('Add'),        
              onPressed: () { 
              
           if (_selectedRole == 'admin') {
            _addAdminUser();        
                Navigator.of(context).pop();   
             
           } else {
            _addUser();
                Navigator.of(context).pop();   

             
           }
                 _AddclassNameController.clear();             
   _AddphotoUrlController.clear();             
   _AddusernameController.clear();         
              },        
            ),        
          ],        
        );        
      },        
    );        
  }        
      
  void _addUser() async {        
    final userManagementProvider = Provider.of<UserManagementProvider>(context, listen: false);        
    final name = _AddnameController.text;        
    final role = _selectedRole;        
    final className = _AddclassNameController.text;        
    final photoUrl = _AddphotoUrlController.text;        
    final username = _AddusernameController.text; // Get username from the controller    
      
    // Validation: Check if required fields are empty        
    if (name.isEmpty || role.isEmpty) {        
      ScaffoldMessenger.of(context).showSnackBar(        
        SnackBar(        
          content: Text('Name and Role are required!'),        
          backgroundColor: Colors.red,        
        ),        
      );        
      return;        
    }        
      
    // Additional validation for students        
    if (role == 'student' && (className.isEmpty || photoUrl.isEmpty)) {        
      ScaffoldMessenger.of(context).showSnackBar(        
        SnackBar(        
          content: Text('Class Name and Photo URL are required for students!'),        
          backgroundColor: Colors.red,        
        ),        
      );        
      return;        
    }        
    
    // Additional validation for admins    
    if (role == 'admin' && username.isEmpty) {    
      ScaffoldMessenger.of(context).showSnackBar(    
        SnackBar(    
          content: Text('Username is required for admins!'),    
          backgroundColor: Colors.red,    
        ),    
      );    
      return;    
    }    
      
    try {        
      await userManagementProvider.addUser(name, role, className, photoUrl, username); // Pass username to add    
      ScaffoldMessenger.of(context).showSnackBar(        
        SnackBar(        
          content: Text('User added successfully!'),        
          backgroundColor: Colors.green,        
        ),        
      );        
    } catch (e) {        
      ScaffoldMessenger.of(context).showSnackBar(        
        SnackBar(        
          content: Text('Error adding user: $e'),        
          backgroundColor: Colors.red,        
        ),        
      );        
    }        
  }        


   void _addAdminUser() async {        
    final userManagementProvider = Provider.of<UserManagementProvider>(context, listen: false);        
    final name = _AddnameController.text;        
    final role = _selectedRole;           
    final username = _AddusernameController.text; // Get username from the controller    
      
    // Validation: Check if required fields are empty        
    if (name.isEmpty || role.isEmpty) {        
      print(role);
      print(name);
      ScaffoldMessenger.of(context).showSnackBar(        
        SnackBar(        
          content: Text('Name and Role ${role} Admin are required!${name}'),        
          backgroundColor: Colors.red,        
        ),        
      );        
      return;        
    }        
        
      
    
    // Additional validation for admins    
    if (role == 'admin' && username.isEmpty) {    
      ScaffoldMessenger.of(context).showSnackBar(    
        SnackBar(    
          content: Text('Username is required for admins!'),    
          backgroundColor: Colors.red,    
        ),    
      );    
      return;    
    }    
      
    try {        
      await userManagementProvider.addAdmin(name, role, username); // Pass username to add    
      ScaffoldMessenger.of(context).showSnackBar(        
        SnackBar(        
          content: Text('User added successfully!'),        
          backgroundColor: Colors.green,        
        ),        
      );        
    } catch (e) {        
      ScaffoldMessenger.of(context).showSnackBar(        
        SnackBar(        
          content: Text('Error adding user: $e'),        
          backgroundColor: Colors.red,        
        ),        
      );        
    }        
  }       
  @override              
  Widget build(BuildContext context) {              
    final userManagementProvider = Provider.of<UserManagementProvider>(context);              
      
    return Scaffold(              
      appBar: AppBar(              
        title: Text('All Users'),              
      ),              
      body: userManagementProvider.isLoading              
          ? Center(child: CircularProgressIndicator())              
          : ListView.builder(              
              itemCount: userManagementProvider.users.length,              
              itemBuilder: (context, index) {              
                final user = userManagementProvider.users[index];             
                return ListTile(              
                  leading: CircleAvatar(              
                    backgroundImage: NetworkImage(user['photoUrl'] ?? ''),              
                    child: user['photoUrl'] == null              
                        ? Icon(Icons.person, color: Colors.white)              
                        : null,              
                  ),              
                  title: Text(user['name'] ?? 'No Name'),              
                  subtitle: Column(              
                    crossAxisAlignment: CrossAxisAlignment.start,              
                    children: [              
                      Text('Role: ${user['role'] ?? 'No Role'}'),              
                      if (user['role'] == 'student')              
                        Text('Class: ${user['className'] ?? 'No Class'}'),              
                      if (user['role'] == 'admin')              
                        Text('Username: ${user['username'] ?? 'No Username'}'), // Display username for admin    
                    ],              
                  ),              
                  trailing: Row(              
                    mainAxisSize: MainAxisSize.min,              
                    children: [              
                      IconButton(              
                        icon: Icon(Icons.edit),              
                        onPressed: () => _showEditUserDialog(user['id'], user),              
                      ),              
                      IconButton(              
                        icon: Icon(Icons.delete),              
                        onPressed: () => _deleteUser(user['id']),              
                      ),              
                    ],              
                  ),              
                );              
              },              
            ),              
      floatingActionButton: Stack(              
        children: [              
          // Add the expandable buttons              
          Positioned(              
            bottom: 16,              
            right: 16,              
            child: Column(              
              mainAxisSize: MainAxisSize.min,              
              children: [              
                // Add Student Button              
                if (_isExpanded)              
                  FloatingActionButton(              
                    onPressed: () => _showAddUserDialog('student'),              
                    child: Text('Student'),              
                  ),              
                // Add Admin Button              
                if (_isExpanded)              
                  FloatingActionButton(              
                    onPressed: () => _showAddUserDialog('admin'),              
                    child: Text('Admin'),              
                  ),              
                // Main FAB              
                FloatingActionButton(              
                  onPressed: () {              
                    setState(() {              
                      _isExpanded = !_isExpanded;              
                    });              
                  },              
                  child: Icon(_isExpanded ? Icons.close : Icons.add),              
                ),              
              ],              
            ),              
          ),              
        ],              
      ),              
    );              
  }              
}              
