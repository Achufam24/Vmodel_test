import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vmodel/src/presentation/notifiers/blog_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (_) => BlogViewModel(),
  ),

];