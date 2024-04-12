import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vmodel/src/data/models/blogs_model.dart';
import 'package:vmodel/src/domain/usecases/blog_usecases.dart';

class BlogViewModel extends ChangeNotifier {
  List<BlogPost>? _blogPosts;
  List<BlogPost>? get blogPost => _blogPosts;
  final FetchAllBlogsUseCase _blogsUseCase= GetIt.instance<FetchAllBlogsUseCase>();

  final DeleteBlogUseCase _deleteblogUseCase= GetIt.instance<DeleteBlogUseCase>();


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  updateBlogs(List<BlogPost> data){
    _blogPosts = data;
    notifyListeners();
  }


  Future<void> fetchBlogPosts() async {
      _isLoading = true;
      _errorMessage = null;

    try {
      final blogPosts = await _blogsUseCase.call();
       updateBlogs(blogPosts);
        _isLoading = false;
    } catch (e) {
        _errorMessage = 'Error fetching blog posts: $e';
        
        _isLoading = false;
    }
    notifyListeners();
  }


  Future<void> deleteBlogPost(String id) async {
      _isLoading = true;
      _errorMessage = null;

    try {
      final blogPosts = await _deleteblogUseCase.call(id);
       fetchBlogPosts();
        _isLoading = false;
    } catch (e) {
        _errorMessage = 'Error fetching blog posts: $e';
        
        _isLoading = false;
    }
    notifyListeners();
  }
}