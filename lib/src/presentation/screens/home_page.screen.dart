import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vmodel/src/core/constants/app_colors.dart';
import 'package:vmodel/src/core/widgets/app_bar.dart';
import 'package:vmodel/src/core/widgets/text.dart';
import 'package:vmodel/src/core/widgets/touchable_opacity.dart';
import 'package:vmodel/src/data/models/blogs_model.dart';
import 'package:vmodel/src/domain/usecases/blog_usecases.dart';
import 'package:vmodel/src/presentation/notifiers/blog_provider.dart';
import 'package:vmodel/src/presentation/screens/blog_detail.screen.dart';
import 'package:vmodel/src/presentation/widgets/add_post_bottom_sheet.dart';
import 'package:vmodel/src/presentation/widgets/blog_card.dart';
import 'package:vmodel/src/presentation/widgets/home_shimmer.dart';
import 'package:vmodel/src/presentation/widgets/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void showAddPostForm(){
    showModalBottomSheet(
      context: context, builder:(context) {
        return const AddPostBottomSheet();
      },
      );
  }

  @override
  void initState() {
   context.read<BlogViewModel>().fetchBlogPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final blogs = context.watch<BlogViewModel>();
    return Scaffold(
      backgroundColor: AppColors.white,
       appBar: VModelAppBar(title: "Feeds", actions: [
        TouchableOpacity(
          onTap:() => showAddPostForm(),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.edit_document, color: AppColors.primaryBlue,),
          ),
        )
       ],),
      body: blogs.isLoading
          ? const HomeScreenShimmer()
          : blogs.errorMessage != null
              ? Center(child: Text(blogs.errorMessage!))
              : blogs.blogPost != null
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: RefreshIndicator(
                       onRefresh: () {
                        return context.read<BlogViewModel>().fetchBlogPosts();
                      },
                      child: ListView.builder(
                          itemCount: blogs.blogPost!.length,
                          itemBuilder: (context, index) {
                            final post = blogs.blogPost![index];
                            return BlogCard(post: post);
                          },
                        ),
                    ),
                  )
                  : Center(

                    child: Column(
                      children: [
                        TextSemiBold("No Post Found"),
                      ],
                    ),
                  )
    );
  }
}