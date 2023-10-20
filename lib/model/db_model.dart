class Db {
  Db({required this.name, required this.fullName, required this.stargazersCount, required this.avatarUrl, required this.description, required this.id});
  late final int id;
  late final String name;
  late final String fullName;
  late final String avatarUrl;
  late final int stargazersCount;
  late final String description;

  Db.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? 'NO Name';
    fullName = json['fullName'] ?? 'No Name';
    avatarUrl = json['avatarUrl'] ?? '';
    stargazersCount = json['stargazersCount'] ?? 0;
    description = json['description'] ?? 'no description';
  }
}
