import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vmodel/src/core/graphl_errors.handler.dart';
import 'package:vmodel/src/data/data_sources/graphql_adapter.dart';
import 'package:vmodel/src/data/data_sources/queries.dart';
import 'package:vmodel/src/data/models/blogs_model.dart';
import 'package:vmodel/src/domain/repositories/blog_repositories.dart';

class BlogRepositoryImpl implements BlogRepository {
  final GraphQlAbstractAdapter _adapter = GetIt.instance<GraphQlAbstractAdapter>();
  

  BlogRepositoryImpl();

  @override
  Future<List<BlogPost>> fetchAllBlogs() async {
    final QueryResult result = await _adapter.query(
      QueryOptions(
        document: gql(Queries.GET_ALL_BLOG_POST),
        pollInterval: const Duration(seconds: 10),
      ),
    );

    

    if (result.hasException) {
       GraphQLErrorHandler.handleError(result.exception as Exception);
    }

    final List<dynamic> blogPosts = result.data?['allBlogPosts'] ?? [];
    return blogPosts.map((post) => BlogPost.fromJson(post)).toList();
  }

  @override
  Future<BlogPost> getBlog(String blogId) async {
    debugPrint(blogId);
    final QueryResult result = await _adapter.query(
      QueryOptions(
        document: gql(Queries.GET_BLOG_POST),
        variables: {'blogId': blogId},
        pollInterval: const Duration(seconds: 10),
      ),
    );

    if (result.hasException) {
      GraphQLErrorHandler.handleError(result.exception as Exception);
    }

    print(result.data);

    final Map<String, dynamic> postData = result.data?['blogPost'] ?? {};
    print(postData);
    return BlogPost.fromJson(postData);
  }

   @override
   Future<Either<Exception, bool>> createBlog(String title, String subTitle, String body) async {
    final MutationOptions options = MutationOptions(
      document: gql(Queries.CREATE_BLOG_POST),
      variables: <String, dynamic>{
        'title': title,
        'subTitle': subTitle,
        'body': body,
      },
      
    );

    final QueryResult result = await _adapter.mutate(options);

    if (result.hasException) {
      return Left(GraphQLErrorHandler.handleError(result.exception as Exception));
    }

    final data = result.data?['createBlog'] as Map<String, dynamic>;
    return Right(data['success'] as bool);

  }

  @override
   Future<Either<Exception, BlogPost>> updateBlog(String blogId, String title, String subTitle, String body) async {
    debugPrint('----->>> ${blogId}  <<<<<-----');
    final MutationOptions options = MutationOptions(
      document: gql(Queries.UPDATE_BLOG_POST),
      variables: <String, dynamic>{
        'title': title,
        'subTitle': subTitle,
        'body': body,
        'blogId': blogId
      },
      
    );

    final QueryResult result = await _adapter.mutate(options);

    if (result.hasException) {
      return Left(GraphQLErrorHandler.handleError(result.exception as Exception));
    }
    print(result.data);

    final data = result.data?['updateBlog'] ?? {};
    final post = BlogPost.fromJson(data['blogPost']);
    return Right(post);

  }

   @override
   Future<Either<Exception, bool>> deleteBlog(String blogId) async {
    final MutationOptions options = MutationOptions(
      document: gql(Queries.DELETE_BLOG_POST),
      variables: {'blogId': blogId},
      
    );

    final QueryResult result = await _adapter.mutate(options);

    if (result.hasException) {
      return Left(GraphQLErrorHandler.handleError(result.exception as Exception));
    }

    final data = result.data?['deleteBlog'] as Map<String, dynamic>;
    return Right(data['success'] as bool);

  }
}
