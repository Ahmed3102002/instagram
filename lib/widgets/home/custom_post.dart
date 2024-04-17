import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social/pages/inner_pages/comments_page.dart';
import 'package:social/providers/like_provider.dart';
import 'package:social/providers/show_posts_provider.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/widgets/others/custom_text.dart';
import 'package:social/widgets/home/custom_little_user_info.dart';

class CustomPost extends StatelessWidget {
  const CustomPost({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final IsLikeProvider isLikeProvider = Provider.of<IsLikeProvider>(context);
    final List<Map<String, dynamic>> postsProvider =
        Provider.of<ShowPostsProvider>(context).getPosts;
    Color color = Theme.of(context).dividerColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLittleUserInfo(
          index: index,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.35,
          child: Swiper(
            pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                size: 5,
                activeSize: 5,
                color: Theme.of(context).scaffoldBackgroundColor,
                activeColor: color,
              ),
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await AppMethods.isLikePostMethod(
                      isLikeProvider, postsProvider, index, context);
                },
                child: FancyShimmerImage(
                  width: double.infinity,
                  imageUrl: postsProvider[index]['postImageUrl'],
                ),
              );
            },
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () async {
                await AppMethods.isLikePostMethod(
                    isLikeProvider, postsProvider, index, context);
              },
              icon: Icon(
                postsProvider[index]['islike']
                    ? IconlyBold.heart
                    : IconlyLight.heart,
                color: postsProvider[index]['islike'] ? Colors.red : color,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.comment_outlined,
                color: color,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                IconlyLight.send,
                color: color,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.save_alt_outlined,
                color: color,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomText(
            title: '${postsProvider[index]['likesCount']} likes',
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomText(
            title: postsProvider[index]['descriptonOfPost'],
            color: color,
            fontSize: 12,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomText(
            title: DateFormat.jm()
                .format(postsProvider[index]['dateOfPost'].toDate()),
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, CommentsPage.routName,
              arguments: postsProvider[index]['postId']),
          child: const CustomText(
            title: 'Add comment ...',
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
