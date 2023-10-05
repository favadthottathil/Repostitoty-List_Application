import 'package:git_hub_api/constants/constants.dart';

class GithubRepository {
  GithubRepository({
    required this.name,
    required this.fullName,
    required this.private,
    required this.htmlUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
    required this.gitUrl,
    required this.stargazersCount,
    required this.watchersCount,
    required this.language,
    required this.owner,
    required this.description,
  });

  late final String name;
  late final String fullName;
  late final bool private;
  late final Owner owner;
  late final String htmlUrl;
  late final String createdAt;
  late final String updatedAt;
  late final String pushedAt;
  late final String gitUrl;
  late final int stargazersCount;
  late final int watchersCount;
  late final String language;
  late final String description;

  GithubRepository.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? 'NO Name';
    fullName = json['full_name'] ?? 'No Name';
    private = json['private'] ?? false;
    htmlUrl = json['html_url'] ?? 'no url';

    owner = Owner.fromjson(json['owner'] ?? {});

    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    pushedAt = json['pushed_at'] ?? '';
    gitUrl = json['git_url'] ?? '';

    language = json['language'] ?? 'dart';

    stargazersCount = json['stargazers_count'] ?? 0;
    watchersCount = json['watchers_count'] ?? 0;

    description = json['description'] ?? 'no description';
  }
}

class Owner {
  Owner({required this.avatarUrl, required this.type});

  late final String avatarUrl;
  late final String type;

  Owner.fromjson(Map<String, dynamic> json) {
    avatarUrl = json['avatar_url'] ?? errorImage;
    type = json['type'] ?? "";
  }
}
