import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vmodel/src/core/graphl_errors.handler.dart';
import 'package:vmodel/src/core/widgets/busy_button.dart';
import 'package:vmodel/src/core/widgets/text.dart';
import 'package:vmodel/src/core/widgets/textbox.dart';
import 'package:vmodel/src/core/widgets/touchable_opacity.dart';
import 'package:vmodel/src/data/models/blogs_model.dart';
import 'package:vmodel/src/domain/usecases/blog_usecases.dart';
import 'package:vmodel/src/presentation/notifiers/blog_provider.dart';

class AddPostBottomSheet extends StatefulWidget {
  const AddPostBottomSheet({super.key, this.post});

  final BlogPost? post;

  @override
  State<AddPostBottomSheet> createState() => _AddPostBottomSheetState();
}

class _AddPostBottomSheetState extends State<AddPostBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final CreateBlogUseCase _blogsUseCase= GetIt.instance<CreateBlogUseCase>();
  final UpdateBlogUseCase _updateblogsUseCase= GetIt.instance<UpdateBlogUseCase>();
  final FetchAllBlogsUseCase _fetchBlogsUseCase= GetIt.instance<FetchAllBlogsUseCase>();

  bool _isLoading = false;
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();
   bool _isFormValid = false;

   void _setFormValidState() {
    setState(() {
      if (_formKey.currentState == null) return;
      if (_formKey.currentState!.validate()) {
        _isFormValid = false;
      }else{
        _isFormValid = true;
      }
    });
  }


  Future<void> _createBlogPosts() async {
    if(mounted){
      setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    }
    try {
      final response = await _blogsUseCase.call(_titleController.text.trim(), _subtitleController.text.trim(), _bodyController.text.trim());
      if (mounted) {
        setState(() {
        _isLoading = false;
        response.fold((l) {
          _errorMessage = GraphQLErrorHandler.handleError(l);
          GraphQLErrorHandler.showErrorDialog(context,_errorMessage.toString());

    }, (r) async{
      if(context.mounted){
        _fetchBlogsUseCase();
        context.read<BlogViewModel>().fetchBlogPosts();
        GraphQLErrorHandler.showErrorDialog(context, r == true ? "Post Created!" : "Post failed!");
      }
    });
      });
      }
    } catch (e) {
      if(mounted){
        setState(() {
        _errorMessage = 'Error fetching blog posts: $e';
        GraphQLErrorHandler.showErrorDialog(context,_errorMessage.toString());
        _isLoading = false;
      });
      }
    }
  }

  @override
  void initState() {
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _subtitleController.text = widget.post!.subTitle;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextSemiBold(widget.post == null ? "Create Post" : "Update Post", fontSize: 18,),
                    TouchableOpacity(
                      onTap: () => context.pop(),
                      child: const Icon(Icons.cancel,))
                  ],
                ),
                const SizedBox(height: 15,),
                CustomTextFormField(
                  labelText: "Title", 
                  controller: _titleController, 
                  onchanged: (value) {
                    _setFormValidState();
                  },
                  validator:(value) {
                   if (value == null) return "Input Title";
                    return null;
  
                },),
                const SizedBox(height: 15,),
                CustomTextFormField(
                  labelText: "SubTitle", 
                  controller: _subtitleController, 
                  onchanged: (value) {
                    _setFormValidState();
                  },
                  validator:(value) {
                      if (value == null) return "Input SubTile";
                      if (value.length < 5) {
                        return "Subtitle must be more than 15 characters";
                      }
                      return null;
                  },
                ),
                const SizedBox(height: 15,),
                CustomTextFormField(
                  labelText: "Body", 
                  controller: _bodyController, 
                  maxline: 4, 
                  onchanged: (value) {
                    _setFormValidState();
                  },
                  validator:(value) {
                    if (value == null) return "Input Body";
                    if (value.length < 15) {
                      return "Body must be more than 15 characters";
                    }
                    return null;
                },),
                const SizedBox(height: 25,),
                BusyButton(
                  title: "Post", 
                  isLoading: _isLoading, 
                  onTap:() {
                  if (_formKey.currentState == null)return;
                  if (_formKey.currentState!.validate()) {
                    if (widget.post == null) {
                      _createBlogPosts();
                    }else{
                      _updateBlogPosts(widget.post!.id, _titleController.text.trim(),_subtitleController.text.trim(), _bodyController.text.trim());
                    }
                    
                  }
                },),
                const SizedBox(height: 25,),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> _updateBlogPosts(String blogId, String title, String subTitle, String body) async {
    if(mounted){
      setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    }
    try {
      final response = await _updateblogsUseCase.call(blogId, title, subTitle, body);
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
        _errorMessage = 'Error updating blog posts: $e';
        GraphQLErrorHandler.showErrorDialog(context,_errorMessage.toString());
        _isLoading = false;
      });
      }
    }
  }
}