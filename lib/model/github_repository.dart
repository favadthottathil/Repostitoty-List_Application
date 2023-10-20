import 'package:git_hub_api/constants/constants.dart';

class GithubRepository {
  GithubRepository({
    required this.name,
    required this.fullName,
    required this.stargazersCount,
    required this.owner,
    required this.description,
  });
  late final String name;
  late final String fullName;
  late final Owner owner;
  late final int stargazersCount;
  late final String description;

  GithubRepository.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? 'name';
    fullName = json['full_name'] ?? 'fullName';
    owner = Owner.fromjson(json['owner']);
    stargazersCount = json['stargazers_count'] ?? 0;
    description = json['description'] ?? 'des';
  }
}

class Owner {
  Owner({required this.avatarUrl});
  late final String avatarUrl;
  Owner.fromjson(Map<String, dynamic> json) {
    avatarUrl = json['avatar_url'] ?? errorImage;
  }
  Map<String, dynamic> toJson() {
    return {
      'avatarUrl': avatarUrl,
    };
  }
}
