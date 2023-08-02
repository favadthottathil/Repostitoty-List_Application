import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:git_hub_api/constants/constants.dart';
import 'package:git_hub_api/model/api_service.dart';
import 'package:sizer/sizer.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchRepositories();
    });

    return Scaffold(
      // ListviewBuilder For Listing Gst Repository Data

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: FutureBuilder<List<RepositoryData>>(
        future: fetchRepositories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(strokeWidth: 2);
          } else if (snapshot.hasError) {
            return Text('Error : ${snapshot.error}');
          } else {
            final List<RepositoryData> repositories = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                final RepositoryData repo = repositories[index];

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
                                  imageUrl: repo.avatharurl,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                  
                                ),
                              ),
                              SizedBox(height: 1.h),
                              SizedBox(
                                width: 25.w,
                                child: Text(
                                  repo.username,
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
                              Text(
                                repo.name,
                                style: AppStyle.poppinsbold15,
                              ),
                              SizedBox(height: 2.h),
                              SizedBox(
                                // color: Colors.greenAccent,
                                width: 58.w,
                                child: Text(
                                  repo.description ?? 'NO description',
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
                                  Text(repo.stars.toString(), style: AppStyle.poppinsbold10)
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
    );
  }


  
}
