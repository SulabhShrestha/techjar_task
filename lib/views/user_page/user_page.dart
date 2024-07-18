import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techjar_task/providers/user_info_provider.dart';
import 'package:techjar_task/view_models/user_view_model.dart';

/// Displays information related to user
class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myInfo = ref.watch(userInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            children: [
              // User details
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(myInfo["name"]),
                  subtitle: Text(myInfo["email"]),
                ),
              ),

              SizedBox(height: 20.h),

              // show all user
              FutureBuilder(
                  future: UserViewModel().getAllUser(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text("Something went wrong"));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, __) => shimmerLoading(),
                          separatorBuilder: (_, __) => SizedBox(height: 8.h),
                          itemCount: 5);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total users: ${snapshot.data!.length}"),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      barrierColor: Colors.black54,
                                      builder: (_) {
                                        return Dialog(
                                          shadowColor: Colors.blue.shade300,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 18.w,
                                                vertical: 8.h),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  richText(
                                                      "Name: ",
                                                      snapshot
                                                          .data![index].name),
                                                  richText(
                                                      "Email: ",
                                                      snapshot
                                                          .data![index].email),
                                                  richText(
                                                      "Phone number: ",
                                                      snapshot
                                                          .data![index].phone),
                                                ]),
                                          ),
                                        );
                                      });
                                },
                                title: Text(snapshot.data![index].username),
                                subtitle: Text(snapshot.data![index].email),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerLoading() => Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: double.infinity,
          height: 52.h,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );

  Widget richText(String firstWord, String secondWord) => Text.rich(
        TextSpan(
          text: firstWord,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black54),
          children: [
            TextSpan(
                text: secondWord, style: const TextStyle(color: Colors.black))
          ],
        ),
      );
}
