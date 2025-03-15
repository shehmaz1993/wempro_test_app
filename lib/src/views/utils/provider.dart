import 'package:provider/provider.dart';
import 'package:wempro_test_app/src/business%20logics/providers/all_attributes_details_provider.dart';
final listOfProvider = [
  ChangeNotifierProvider<AllAttributeDetailsProvider>(create: (_) => AllAttributeDetailsProvider()),

];