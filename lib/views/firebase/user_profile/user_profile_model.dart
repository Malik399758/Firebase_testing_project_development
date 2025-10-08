
class ProfileModel{
  final String firstName;
  final String lastName;
  final String email;
  final String city;


  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city
});

  /// model to map

 Map<String ,dynamic> toMap(){
   return {
     'firstName' : firstName,
     'lastName' : lastName,
     'email' : email,
     'city' : city
   };
 }

 /// firebase to model

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    print('Mapping data from Firestore: $map');
    return ProfileModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      city: map['city'] ?? '',
    );
  }

}