// import 'package:cloud_firestore/cloud_firestore.dart';    
// import 'package:flutter/material.dart';    
  
// class UserManagementProvider with ChangeNotifier {    
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;    
//   bool _isLoading = false; // To track loading state    
//   List<Map<String, dynamic>> _users = []; // To store users  
  
//   // Getter for loading state    
//   bool get isLoading => _isLoading;    
  
//   // Getter for users    
//   List<Map<String, dynamic>> get users => _users;    
  
//   // Fetch all users (students and admins)    
//   Future<void> fetchAllUsers() async {    
//     _isLoading = true; // Start loading    
//     notifyListeners();    
  
//     try {    
//       final userSnapshot = await _firestore.collection('users').get();    
//       _users = []; // Clear the previous users list  
//       for (var doc in userSnapshot.docs) {    
//         _users.add({    
//           'id': doc.id,    
//           ...doc.data() as Map<String, dynamic>,    
//         });    
//       }    
//     } catch (e) {    
//       print('Error fetching users from Firestore: $e');    
//     }    
  
//     _isLoading = false; // End loading    
//     notifyListeners();    
//   }    
  
//   // Update user details    
//   Future<void> updateUser(String userId, String name, String role, String className, String photoUrl) async {    
//     try {    
//       await _firestore.collection('users').doc(userId).update({    
//         'name': name,    
//         'role': role,    
//         'className': className,    
//         'photoUrl': photoUrl,    
//       });    
//       // Optionally, update the local users list after updating  
//       final userIndex = _users.indexWhere((user) => user['id'] == userId);  
//       if (userIndex != -1) {  
//         _users[userIndex] = {  
//           'id': userId,  
//           'name': name,  
//           'role': role,  
//           'className': className,  
//           'photoUrl': photoUrl,  
//         };  
//       }  
//       notifyListeners();    
//     } catch (e) {    
//       print('Error updating user: $e');    
//       throw e;    
//     }    
//   }    
  
//   // Delete user    
//   Future<void> deleteUser(String userId) async {    
//     try {    
//       await _firestore.collection('users').doc(userId).delete();    
//       // Remove the user from the local list  
//       _users.removeWhere((user) => user['id'] == userId);  
//       notifyListeners();    
//     } catch (e) {    
//       print('Error deleting user: $e');    
//       throw e;    
//     }    
//   }    
// }    
import 'package:cloud_firestore/cloud_firestore.dart';        
import 'package:flutter/material.dart';        
  
class UserManagementProvider with ChangeNotifier {        
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;        
  bool _isLoading = false; // To track loading state        
  List<Map<String, dynamic>> _users = []; // To store users      
      
  // Getter for loading state        
  bool get isLoading => _isLoading;        
      
  // Getter for users        
  List<Map<String, dynamic>> get users => _users;        
      
  // Fetch all users (students and admins)        
  Future<void> fetchAllUsers() async {        
    _isLoading = true; // Start loading        
    notifyListeners();        
      
    try {        
      final userSnapshot = await _firestore.collection('users').get();        
      _users = []; // Clear the previous users list      
      for (var doc in userSnapshot.docs) {        
        _users.add({        
          'id': doc.id,        
          ...doc.data() as Map<String, dynamic>,        
        });        
      }        
    } catch (e) {        
      print('Error fetching users from Firestore: $e');        
    }        
      
    _isLoading = false; // End loading        
    notifyListeners();        
  }        
      
  // Add a new user        
  Future<void> addUser(String name, String role, String className, String photoUrl, String username) async {        
    try {        
      // Create a new user document in Firestore        
      DocumentReference docRef = await _firestore.collection('users').add({        
        'name': name,        
        'role': role,        
        'className': className,        
        'photoUrl': photoUrl,    
        'username': username, // Add username to Firestore        
      });        
      
      // Add the new user to the local users list        
      _users.add({        
        'id': docRef.id,        
        'name': name,        
        'role': role,        
        'className': className,        
        'photoUrl': photoUrl,        
        'username': username, // Add username to local list        
      });        
      notifyListeners();        
    } catch (e) {        
      print('Error adding user: $e');        
      throw e;        
    }        
  }      
  Future<void> addAdmin(String name, String role,  String username) async {        
    try {        
      // Create a new user document in Firestore        
      DocumentReference docRef = await _firestore.collection('users').add({        
        'name': name,        
        'role': role,        
        'username': username, // Add username to Firestore        
      });        
      
      // Add the new user to the local users list        
      _users.add({        
        'id': docRef.id,        
        'name': name,        
        'role': role,        
        'username': username, // Add username to local list        
      });        
      notifyListeners();        
    } catch (e) {        
      print('Error adding user: $e');        
      throw e;        
    }        
  }        
      
  // Update user details        
  Future<void> updateUser(String userId, String name, String role, String className, String photoUrl, String username) async {        
    try {        
      await _firestore.collection('users').doc(userId).update({        
        'name': name,        
        'role': role,        
        'className': className,        
        'photoUrl': photoUrl,        
        'username': username, // Update username in Firestore        
      });        
      // Optionally, update the local users list after updating      
      final userIndex = _users.indexWhere((user) => user['id'] == userId);      
      if (userIndex != -1) {      
        _users[userIndex] = {      
          'id': userId,      
          'name': name,      
          'role': role,      
          'className': className,      
          'photoUrl': photoUrl,      
          'username': username, // Update username in local list      
        };      
      }      
      notifyListeners();        
    } catch (e) {        
      print('Error updating user: $e');        
      throw e;        
    }        
  }        
      
  // Delete user        
  Future<void> deleteUser(String userId) async {        
    try {        
      await _firestore.collection('users').doc(userId).delete();        
      // Remove the user from the local list      
      _users.removeWhere((user) => user['id'] == userId);      
      notifyListeners();        
    } catch (e) {        
      print('Error deleting user: $e');        
      throw e;        
    }        
  }        
}        
