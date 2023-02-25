class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? profType;
  final String? language;
  final String? address;
  final String? about;
  final String? profileUrl;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.profType,
    this.language,
    this.address,
    this.about,
    this.profileUrl,
  });

  toJson() {
    return {
      "Name": name,
      "Email": email,
      "Password": password,
      "profType": profType,
      "language": language,
      "address": address,
      "about": about,
      'profileUrl': profileUrl
    };
  }
}
