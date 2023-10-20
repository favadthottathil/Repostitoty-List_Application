import 'package:flutter/material.dart';
import 'package:git_hub_api/model/db_model.dart';

class GitHubDataProvider extends ChangeNotifier {
  List<Db> _githubData = [];
  
  bool _hasInternetConnection = false;
  bool _noData = false;
  bool _loading = false;
  bool _fetchDataBool = false;

  List<Db> get githubData => _githubData;
  bool get hasInternetConnection => _hasInternetConnection;
  bool get noData => _noData;
  bool get loading => _loading;
  bool get fetchDataBool => _fetchDataBool;

  void setGithubData(List<Db> data) {
    _githubData = data;
    notifyListeners();
  }

  void setHasInternetConnection(bool value) {
    _hasInternetConnection = value;
    notifyListeners();
  }

  void setNoData(bool value) {
    _noData = value;
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setFetchDataBool(bool value) {
    _fetchDataBool = value;
    notifyListeners();
  }

  void setFetchDataBool2(bool value) {
    _fetchDataBool = value;
  }

  getDataProvider(List<Db> value) {
    _githubData = [];
    _githubData.addAll(value);
    if (_githubData.isEmpty) {
      _fetchDataBool = true;
      notifyListeners();
    }
    print(_githubData);
    notifyListeners();
  }
}
