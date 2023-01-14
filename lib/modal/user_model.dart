final String tableUsers = 'users';

class UserFields {
  static final String userID = 'userID';
  static final String mobile = 'mobile';
  static final String password = 'password';
  static final String eMail = 'eMail';
  static final String userName = 'userName';
  
}

class Users {
  final int userID ;
  final String  mobile;
  final String password;
  final String eMail;
  final String userName;
  

  const Users(
      {required this.userID,
      required this.mobile,
      required this.password,
      required this.eMail,
      required this.userName
      });
}
