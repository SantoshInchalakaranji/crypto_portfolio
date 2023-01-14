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

      Map<String, Object?> toJson() => {
       UserFields.userID : userID,
       UserFields.eMail: eMail,
       UserFields.mobile:mobile,
       UserFields.password: password,
       UserFields.userName:userName
      };

      Users copy({
          int? userID,
   String?  mobile,
   String? password,
   String? eMail,
   String? userName
      }) => Users(userID: userID?? this.userID,
       mobile: mobile?? this.mobile,
        password: password?? this.password,
         eMail: eMail?? this.eMail,
          userName: userName?? this.userName);
}
