import 'dart:convert';
import 'package:git_hub_api/model/github_repository.dart';
import 'package:http/http.dart' as http;

class GithubRepositoryApi {
  String apiEndPoint = 'https://api.github.com/search/repositories?q=created:>2023-09-04&sort=stars&order=desc';

  Future<List<GithubRepository>> getData() async {
    Uri url = Uri.parse(apiEndPoint);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);



      final List data = json['items'];

      List<GithubRepository> githubData = data.map((item) => GithubRepository.fromJson(item)).toList();

      return githubData;
    } else {
      throw Exception("can't get data from api");
    }
  }
}
