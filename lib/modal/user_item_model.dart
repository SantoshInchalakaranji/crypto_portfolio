import 'package:crypto_portfolio/modal/user_model.dart';

class UserItemModel {
  final int userID;
  final String userName;
  final String userMobile;
  
 

  UserItemModel(
      {required this.userID,
      required this.userMobile,
      required this.userName,
    
      });

      
  static UserItemModel fromJson(Map<String, Object?> json) => UserItemModel(
    userID: json[UserFields.userID] as int,
    userMobile: json[UserFields.mobile] as String,
    userName: json[UserFields.userName] as String
  );
}
