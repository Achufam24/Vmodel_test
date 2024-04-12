import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlAbstractAdapter {

  final GraphQLClient _client = GetIt.instance<GraphQLClient>();


Future<QueryResult> query(QueryOptions options) {
  return _client.query(options);
 }

Future<QueryResult> mutate(MutationOptions options) {
 return _client.mutate(options);
 }
}