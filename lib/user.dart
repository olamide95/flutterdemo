class User {

  String firstname;
  String lastname;
  String email;
  String phone;
  String password;
  String userId;

  User({ this.firstname,  this.lastname,  this.email,  this.phone,  this.password,  this.userId });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId:responseData['userId'] ,
        firstname: responseData['firstname'],
        lastname: responseData['lastname'],
        email: responseData['email'],
        phone: responseData['phone'],
        password: responseData['password'],
    );
  }
}
