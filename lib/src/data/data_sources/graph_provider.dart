import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';



final HttpLink httpLink = HttpLink(
  'https://uat-api.vmodel.app/graphql/',
);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(
       store: InMemoryStore(),
    ),
    defaultPolicies: DefaultPolicies(
      query: Policies(
         fetch: FetchPolicy.cacheFirst
      ),
    ),
  ),
  
);