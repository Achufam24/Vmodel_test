
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vmodel/src/core/constants/app_colors.dart';
import 'package:vmodel/src/core/fonts/app_fonts.dart';
import 'package:vmodel/src/core/graphl_errors.handler.dart';
import 'package:vmodel/src/core/utils/app_functions.dart';
import 'package:vmodel/src/core/utils/logger.dart';
import 'package:vmodel/src/core/widgets/app_bar_two.dart';
import 'package:vmodel/src/core/widgets/text.dart';
import 'package:vmodel/src/core/widgets/touchable_opacity.dart';
import 'package:vmodel/src/data/models/blogs_model.dart';
import 'package:vmodel/src/domain/usecases/blog_usecases.dart';
import 'package:vmodel/src/presentation/notifiers/blog_provider.dart';
import 'package:vmodel/src/presentation/widgets/add_post_bottom_sheet.dart';
import 'package:vmodel/src/presentation/widgets/single_scroll_child.view.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({super.key, required this.post});
  final BlogPost post;

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  final GetBlogUseCase _blogUseCase = GetIt.instance<GetBlogUseCase>();
  final DeleteBlogUseCase _deleteBlogUseCase = GetIt.instance<DeleteBlogUseCase>();


  BlogPost? _blogPost;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _fetchBlogPosts() async {
    if (mounted) {
      setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    }
    try {
      final blogPosts = await _blogUseCase.call(widget.post.id);
      if (mounted) {
        setState(() {
        _blogPost = blogPosts;
        _isLoading = false;
      });
      }
      
    } catch (e) {
      if (mounted) {
        setState(() {
        _errorMessage = 'Error fetching blog posts: $e';
        GraphQLErrorHandler.showErrorDialog(context, _errorMessage.toString());
        debugPrint(_errorMessage);
        _isLoading = false;
      });
      }
      
    }
  }

  void showAddPostForm(BlogPost paylaod){
    showModalBottomSheet(
      context: context, builder:(context) {
        return AddPostBottomSheet(post:paylaod);
      },
      ).then((value) {
        logger.d('kjn.ejnjk.nekwej$value');
        if (value == null)return;
        setState(() {
          _blogPost = value;
        });
      });
  }

  @override
  void initState() {
   _fetchBlogPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: VModelAppBarTwo(title: 'Post: ${widget.post.id}', actions: [
       TouchableOpacity(
          onTap:() => showAddPostForm(widget.post),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.edit_note, color: AppColors.primaryBlue,),
          ),
        )
      ],),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _blogPost != null
                  ? CustomSingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBold(
                              AppFunctions.capitalize(_blogPost!.title,),
                              
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextSemiBold(
                              _blogPost!.subTitle,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontFamily: AppFonts.manRope,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _blogPost!.body,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: AppFonts.manRope
                              ),
                            ),
                            const SizedBox(height: 16),
                            RichText(
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.start,       
                              textDirection: TextDirection.rtl,       
                              softWrap: true,
                              maxLines: 1,
                          
                              text: TextSpan(
                                text: 'Posted on: ',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppFonts.manRope,
                                  color: AppColors.background
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${AppFunctions.getFormattedDate(_blogPost?.dateCreated.toString() ?? "")} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(
                                      text: AppFunctions.getFormattedPeriod(_blogPost?.dateCreated.toString() ?? ""), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Center(child: TouchableOpacity(
                              onTap:() => _deleteBlog(_blogPost!.id),
                              child: TextSemiBold("Delete Post", color: Colors.red, fontSize: 16, textAlign: TextAlign.center, ))),
                    
                          ],
                        ),
                      ),
                  )
                  : const SizedBox.shrink(),
    );
  }

   Future<void> _deleteBlog(String blogId) async {
    if(mounted){
      setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    }
    try {
      final response = await _deleteBlogUseCase.call(blogId);
      if (mounted) {
        setState(() {
        _isLoading = false;
        response.fold((l) {
          _errorMessage = GraphQLErrorHandler.handleError(l);
          GraphQLErrorHandler.showErrorDialog(context,_errorMessage.toString());

    }, (r) async{
      if(context.mounted){
        setState(() {
          context.pop(r);
        });
        context.read<BlogViewModel>().fetchBlogPosts();
      }
    });
      });
      }
    } catch (e) {
      if(mounted){
        setState(() {
        _errorMessage = 'Error deleting blog posts: $e';
        GraphQLErrorHandler.showErrorDialog(context,_errorMessage.toString());
        _isLoading = false;
      });
      }
    }
  }
}