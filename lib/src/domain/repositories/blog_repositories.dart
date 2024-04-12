import 'package:dartz/dartz.dart';
import 'package:vmodel/src/data/models/blogs_model.dart';

abstract class BlogRepository {
  Future<List<BlogPost>> fetchAllBlogs();
  Future<BlogPost> getBlog(String blogId);
  Future<Either<Exception, bool>> createBlog(String title, String subTitle, String body);
  Future<Either<Exception, BlogPost>> updateBlog(String blogId, String title, String subTitle, String body);
  Future<Either<Exception, bool>> deleteBlog(String blogId);
}
