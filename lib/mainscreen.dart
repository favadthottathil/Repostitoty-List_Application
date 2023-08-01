import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:git_hub_api/constants/constants.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ListviewBuilder For Listing Gst Repository Data

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 20.h,
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
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: kwhite,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'userName',
                          style: AppStyle.poppinsbold10,
                        )
                      ],
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Repository Name',
                          style: AppStyle.poppinsbold15,
                        ),
                        SizedBox(height: 2.h),
                        Flexible(
                          child: Container(
                            // color: Colors.greenAccent,
                            width: 58.w,
                            child: Text(
                              'Repostary Descriptionbadbnbnasnfnananbfnannbfaaanahfhakjfjdsjsajassjdjsaaaajjajkhfdaj',
                              style: AppStyle.poppinsbold10,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(width: 1.w),
                            Text('1000', style: AppStyle.poppinsbold10)
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
        itemCount: 10,
      ),
    );
  }
}
