import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vmodel/src/data/models/blogs_model.dart';
import 'package:vmodel/src/domain/repositories/blog_repositories.dart';

final BlogRepository repository = GetIt.instance<BlogRepository>();

class FetchAllBlogsUseCase {
  FetchAllBlogsUseCase();

  Future<List<BlogPost>> call() async {
    return await repository.fetchAllBlogs();
  }
}

class GetBlogUseCase {

  Future<BlogPost> call(String blogId) async {
    return await repository.getBlog(blogId);
  }
}

class CreateBlogUseCase {

  Future<Either<Exception, bool>> call(String title, String subTitle, String body) async {
    return await repository.createBlog(title, subTitle, body);
  }
}

class UpdateBlogUseCase {

  Future<Either<Exception, BlogPost>> call(String blogId, String title, String subTitle, String body) async {
    debugPrint('HH${blogId}');
    return await repository.updateBlog(blogId,title, subTitle, body);
  }
}

class DeleteBlogUseCase {
  Future<Either<Exception, bool>> call(String blogId) async {
    return await repository.deleteBlog(blogId);
  }
}