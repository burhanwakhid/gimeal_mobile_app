class UserModel {
  final String id;
  final String nama;
  final String email;
  final String noHp;
  final String createdAt;

  UserModel(this.id, this.email, {this.nama, this.noHp, this.createdAt});
}