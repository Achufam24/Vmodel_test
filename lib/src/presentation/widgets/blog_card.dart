import 'package:flutter/material.dart';
import 'package:vmodel/src/core/constants/app_colors.dart';
import 'package:vmodel/src/core/fonts/app_fonts.dart';
import 'package:vmodel/src/core/utils/app_functions.dart';
import 'package:vmodel/src/core/widgets/text.dart';
import 'package:vmodel/src/core/widgets/touchable_opacity.dart';
import 'package:vmodel/src/data/models/blogs_model.dart';
import 'package:vmodel/src/presentation/screens/blog_detail.screen.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.post});

  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
       onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailScreen(post: post,),
          ),
        );
      },
      child: Card(         
        elevation: 1,   
        color: AppColors.white,               
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBold(
                  '${AppFunctions.capitalize(post.title)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                TextSemiBold(post.body, fontWeight: FontWeight.w400, color: AppColors.textPrimaryColor2,),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextSemiBold('Read More', fontSize: 14,),
                    Center(child: Icon(Icons.arrow_right_alt))
                  ],
                ),
   
              ],
            ),
          ),
        ),
    );
  }
}