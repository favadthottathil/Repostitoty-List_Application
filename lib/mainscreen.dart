import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:git_hub_api/api/github_api.dart';
import 'package:git_hub_api/constants/constants.dart';
import 'package:sizer/sizer.dart';
import 'model/github_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // ListviewBuilder For Listing Gst Repository Data

        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/giihub.jpg'), fit: BoxFit.cover),
          ),
          child: FutureBuilder<List<GithubRepository>>(
            future: GithubRepositoryApi().getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitWave(
                    color: Colors.black,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error : ${snapshot.error}');
              } else {
                final List<GithubRepository> repositories = snapshot.data!;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final GithubRepository repo = repositories[index];

                    return Padding(
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
                                      imageUrl: repo.owner.avatarUrl,
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
                    );
                  },
                  itemCount: repositories.length,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
