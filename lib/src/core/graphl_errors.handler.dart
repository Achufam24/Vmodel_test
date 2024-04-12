import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLErrorHandler {
  static handleError(Object error) {
    if (error is OperationException) {
      if (error.linkException is ServerException) {
        final serverException = error.linkException as ServerException;
        final graphqlErrors = serverException.parsedResponse?.errors;
        if (graphqlErrors != null && graphqlErrors.isNotEmpty) {
          final errorMessage = graphqlErrors.first.message;
          throw Exception('GraphQL Error: $errorMessage');
        }
      }
      throw Exception('GraphQL Error: ${error.toString()}');
    } else {
      throw Exception('Unexpected Error: $error');
    }
  }

  static showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}