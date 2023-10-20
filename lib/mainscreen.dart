import 'dart:async';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:git_hub_api/Database/sqflite_db.dart';
import 'package:git_hub_api/api/github_api.dart';
import 'package:git_hub_api/constants/constants.dart';
import 'package:git_hub_api/provider/githubdata_provider.dart';
import 'package:git_hub_api/shared_preference/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 

  late GitHubDataProvider githubProvider;

  ScrollController scrollController = ScrollController();

  bool hasInternetConnection = false;

  

  bool noData = false;

 

  fetchData(value) async {
    try {
      int? currentPage = await CurrentPageSharedPfr.getCurrentPageFromSharedPrf();

      currentPage ??= 1;

      log(currentPage.toString());

      await GithubRepositoryApi().getData(currentPage).then((allDataList) async {
        await GithubRepositoryDatabase().insertGithubRepository(allDataList).then((_) {
          getDataFromDb(value);

          CurrentPageSharedPfr.storeCurrentPageToSharedPrf(currentPage! + 1);
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }

  fetchMore() async {
    githubProvider.setLoading(true);

    int? currentPage = await CurrentPageSharedPfr.getCurrentPageFromSharedPrf();

    currentPage ??= 1;

    log(currentPage.toString());

    await GithubRepositoryApi().getData(currentPage).then((allDataList) async {
      await GithubRepositoryDatabase().insertGithubRepository(allDataList).then((_) {
        getDataFromDb(githubProvider).then((_) {
          CurrentPageSharedPfr.storeCurrentPageToSharedPrf(currentPage! + 1);
          githubProvider.setLoading(false);
        });
      });
    });
  }

  listner() async {
    if (hasInternetConnection == true && scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      fetchMore();
    }
  }

  favad() async {
    await GithubRepositoryDatabase().dropTable();
    // fetchData();
  }

  Future getDataFromDb(GitHubDataProvider provider) async {
    GithubRepositoryDatabase().getDataFromDb().then((value) {
      
      provider.getDataProvider(value);
    
      // setState(() {
      //   githubData = [];
      //   githubData.addAll(value);
      //   if (githubData.isEmpty) {
      //     fetchDataBool = true;
      //   }
      // });
    });
  }

  @override
  void initState() {
    super.initState();

    // getDataFromDb();

    // favad();

    scrollController.addListener(listner);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      githubProvider = Provider.of<GitHubDataProvider>(context, listen: false);

      getDataFromDb(githubProvider);
    });

    return SafeArea(
      child: Scaffold(
        // ListviewBuilder For Listing Gst Repository Data

        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/giihub.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Consumer<GitHubDataProvider>(builder: (context, value, child) {
              githubProvider = value;
              return StreamBuilder(
                stream: Connectivity().onConnectivityChanged,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final result = snapshot.data;

                    if (result == ConnectivityResult.none) {
                      log('offline');
                      hasInternetConnection = false;
                      // value.setHasInternetConnection(false);
                    } else {
                      log('online');

                      hasInternetConnection = true;
                      // value.setHasInternetConnection(true);
                    }

                    if (value.githubData.isEmpty && hasInternetConnection && value.fetchDataBool) {
                      fetchData(value);

                      value.setFetchDataBool2(false);
                    } else if (value.githubData.isEmpty && !hasInternetConnection) {
                      value.setNoData(true);
                    }

                    return Stack(
                      children: [
                        AnimationLimiter(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: value.loading ? value.githubData.length + 1 : value.githubData.length,
                            itemBuilder: (
                              context,
                              index,
                            ) {
                              if (index < value.githubData.length) {
                                final repo = value.githubData[index];
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: ScaleAnimation(
                                    // verticalOffset: 50,
                                    child: FadeInAnimation(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: kblack,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(1.h),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    CircularProfileAvatar(
                                                      '',
                                                      radius: 50,
                                                      backgroundColor: kwhite,
                                                      child: CachedNetworkImage(
                                                        imageUrl: repo.avatarUrl,
                                                        placeholder: (context, url) => const Center(
                                                          child: SpinKitCircle(color: Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    SizedBox(
                                                      width: 25.w,
                                                      child: Text(
                                                        repo.name,
                                                        style: AppStyle.poppinsbold10,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 8.w),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 58.w,
                                                      child: Text(
                                                        repo.fullName,
                                                        style: AppStyle.poppinsbold15,
                                                        // maxLines: 1,
                                                        // overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    SizedBox(
                                                      width: 58.w,
                                                      child: Text(
                                                        repo.description,
                                                        style: AppStyle.poppinsbold10,
                                                        // overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                        ),
                                                        SizedBox(width: 1.w),
                                                        Text(repo.stargazersCount.toString(), style: AppStyle.poppinsbold10)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return null;
                            },
                          ),
                        ),
                        if (value.loading)
                          const Center(
                            child: SpinKitWave(
                              color: Colors.white,
                            ),
                          ),
                        if (value.noData)
                          const Column(
                            children: [
                              Center(
                                child: Text('NO Internet'),
                              ),
                              Icon(Icons.network_wifi_1_bar_outlined)
                            ],
                          )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    log('${snapshot.error} failed to checkInternet');
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.black,
                      ),
                    );
                  }
                },
              );
            })),
      ),
    );
  }
}
