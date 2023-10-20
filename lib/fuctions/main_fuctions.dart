// import 'dart:developer';

// import 'package:git_hub_api/Database/sqflite_db.dart';
// import 'package:git_hub_api/api/github_api.dart';
// import 'package:git_hub_api/shared_preference/shared_pref.dart';
// import 'package:path/path.dart';
// import 'package:provider/provider.dart';

// import '../model/db_model.dart';
// import '../provider/githubdata_provider.dart';

// class Mainfuctions {
//   late GitHubDataProvider gitHubDataProvider;

//   List<Db> githubData = [];

//   fetchData() async {
//     try {
//       int? currentPage = await CurrentPageSharedPfr.getCurrentPageFromSharedPrf();

//       currentPage ??= 1;

//       log(currentPage.toString());

//       await GithubRepositoryApi().getData(currentPage).then((allDataList) async {
//         await GithubRepositoryDatabase().insertGithubRepository(allDataList).then((_) {
//           getDataFromDb();

//           CurrentPageSharedPfr.storeCurrentPageToSharedPrf(currentPage! + 1);
//         });
//       });
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   fetchMore() async {
//     // setState(() {
//     //   loading = true;
//     // });

//     gitHubDataProvider.setLoading(true);
//     int? currentPage = await CurrentPageSharedPfr.getCurrentPageFromSharedPrf();

//     currentPage ??= 1;

//     log(currentPage.toString());

//     await GithubRepositoryApi().getData(currentPage).then((allDataList) async {
//       await GithubRepositoryDatabase().insertGithubRepository(allDataList).then((_) {
//         getDataFromDb().then((_) {
//           CurrentPageSharedPfr.storeCurrentPageToSharedPrf(currentPage! + 1);
//           // setState(() {
//           //   loading = false;
//           // });
//           gitHubDataProvider.setLoading(false);
//         });
//       });
//     });
//   }

//   Future getDataFromDb(GitHubDataProvider provider, List<Db> githubData) async {
//     GithubRepositoryDatabase().getDataFromDb().then((value) {
//       provider.getDataProvider(githubData, value);
//       // setState(() {
//       //   githubData = [];
//       //   githubData.addAll(value);
//       //   if (githubData.isEmpty) {
//       //     fetchDataBool = true;
//       //   }
//       // });
//     });
//   }
// }
