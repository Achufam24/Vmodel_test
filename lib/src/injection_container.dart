import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vmodel/src/core/graphl_errors.handler.dart';
import 'package:vmodel/src/core/navigation/app_router.dart';
import 'package:vmodel/src/data/data_sources/graphql_adapter.dart';
import 'package:vmodel/src/data/repositories/blog.repositoryImpl.dart';
import 'package:vmodel/src/domain/repositories/blog_repositories.dart';
import 'package:vmodel/src/domain/usecases/blog_usecases.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async{
  final HttpLink httpLink = HttpLink(
  'https://uat-api.vmodel.app/graphql/',
);
  getIt.registerLazySingleton<GraphQLClient>(() => GraphQLClient(
    link: httpLink, 
   defaultPolicies: DefaultPolicies(
    query: Policies(
      cacheReread: CacheRereadPolicy.ignoreAll,
      fetch: FetchPolicy.networkOnly,
    ),
  ),
  cache: GraphQLCache(store: HiveStore()),
  ) 
  );

  getIt.registerLazySingleton<GraphQlAbstractAdapter>(
        () => GraphQlAbstractAdapter(),
  );

  getIt.registerLazySingleton<BlogRepository>(
        () => BlogRepositoryImpl(),
  );

  getIt.registerLazySingleton<FetchAllBlogsUseCase>(
        () => FetchAllBlogsUseCase(),
  );

  getIt.registerLazySingleton<GetBlogUseCase>(
        () => GetBlogUseCase(),
  );

  getIt.registerLazySingleton<CreateBlogUseCase>(
        () => CreateBlogUseCase(),
  );

   getIt.registerLazySingleton<UpdateBlogUseCase>(
        () => UpdateBlogUseCase(),
  );

  getIt.registerLazySingleton<DeleteBlogUseCase>(
        () => DeleteBlogUseCase(),
  );
  
  getIt.registerLazySingleton<GraphQLErrorHandler>(
          () => GraphQLErrorHandler(),
    );

  getIt.registerSingleton<GoRouter>(AppRoutes().router);

}