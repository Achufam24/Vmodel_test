import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vmodel/src/app.dart';
import 'package:vmodel/src/injection_container.dart';

void main() async {
  await initHiveForFlutter();
  setupDependencies();
  runApp(const VmodelApp());
}
