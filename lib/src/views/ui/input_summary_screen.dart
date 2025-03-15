import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wempro_test_app/src/views/utils/Size.dart';
import 'package:wempro_test_app/src/views/widgets/shadow_flex_container.dart';

import '../../business logics/providers/all_attributes_details_provider.dart';
class InputSummaryScreen extends StatelessWidget {
   InputSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllAttributeDetailsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Selected Input',style: TextStyle(fontWeight: FontWeight.bold),),
        //centerTitle: true,
        actions: [
          Text('5 items',style: TextStyle(fontSize: SizeConfig.blockSizeVertical*1.9, fontWeight: FontWeight.bold))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              'Selected Input',
              style: TextStyle(fontSize: SizeConfig.blockSizeVertical*2.3, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ShadowFlexContainer(
              radius: 8,
              child: Padding(
                padding:  EdgeInsets.all(SizeConfig.blockSizeVertical*0.09),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectionItem(title: 'Include Outdoor Assist Single Family', value: provider.selectedOutdoor!),
                    SelectionItem(title: 'Number of Bedrooms', value:  provider.selectedBedrooms!),
                    SelectionItem(title: 'Number of Bathrooms', value:  provider.selectedBathrooms!),
                    SelectionItem(title: 'Cleaning Frequency', value: provider.selectedCleaningFrequency!),
                    SelectionItem(title: 'Include garage cleaning', value: provider.selectedGarage!),
                    //SizedBox(height: SizeConfig.blockSizeVertical*1),
                    ListTile(
                      leading:Text(
                        'Edit Selection',
                        style: TextStyle(fontSize: SizeConfig.blockSizeVertical*1.7,fontWeight: FontWeight.bold),),
                      trailing: IconButton(
                          onPressed: (){

                          },
                          icon: const Icon(Icons.arrow_forward_ios_outlined)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical*47),
            ShadowFlexContainer(
              radius: 0,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context,'update');
                    },
                    style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.green, // Set the text color to white
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20), // Optional padding
                   ),
                  child: const Text('Back'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class SelectionItem extends StatelessWidget {
  final String title;
  final String value;

  SelectionItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title:', style: TextStyle(fontSize: SizeConfig.blockSizeVertical*1.7,fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontSize: SizeConfig.blockSizeVertical*1.6, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}