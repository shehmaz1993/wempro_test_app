import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wempro_test_app/src/business%20logics/providers/all_attributes_details_provider.dart';
import 'package:wempro_test_app/src/views/ui/input_summary_screen.dart';
import 'package:wempro_test_app/src/views/widgets/shadow_flex_container.dart';

import '../utils/Size.dart';
import '../widgets/scaffold_message.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider =
      Provider.of<AllAttributeDetailsProvider>(context, listen: false);
      provider.getAllAttributes();


    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Input Types'),
          centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Consumer<AllAttributeDetailsProvider>(builder: (context,attributeProvider,child)=>
            attributeProvider.getAllAttributesInProgress
                ?const Center(child: CircularProgressIndicator()):
                Form(
                  key: _formKey,
                    child:Column(

                      children: [
                        buildRadioGroup(
                            'Include Outdoor Area',
                            attributeProvider.attributesResponseModel.jsonResponse!.attributes![0].options!,
                            'propertyType',
                            attributeProvider
                        ),
                        ShadowFlexContainer(
                            radius: 0,
                            child: Padding(
                              padding:  EdgeInsets.all(SizeConfig.blockSizeVertical*2),
                              child: Column(
                                children: [
                                  buildDropdown(
                                      attributeProvider.attributesResponseModel.jsonResponse!.attributes![1].title!,
                                      attributeProvider.attributesResponseModel.jsonResponse!.attributes![1].options!,
                                      'bedrooms',
                                      attributeProvider
                                  ),
                                  buildDropdown(
                                      attributeProvider.attributesResponseModel.jsonResponse!.attributes![2].title!,
                                      attributeProvider.attributesResponseModel.jsonResponse!.attributes![2].options!,
                                      'bathrooms',
                                      attributeProvider
                                  ),
                                ],
                              ),
                            )
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical*1,),
                        ShadowFlexContainer(
                          radius: 0,
                          child: buildRadioGroup(
                              attributeProvider.attributesResponseModel.jsonResponse!.attributes![3].title!,
                              attributeProvider.attributesResponseModel.jsonResponse!.attributes![3].options!,
                              'cleaningFrequency',
                              attributeProvider
                          ),
                        ),
                        ShadowFlexContainer(
                          radius: 0,
                          child: buildCheckboxGroup(
                              attributeProvider.attributesResponseModel.jsonResponse!.attributes![4].title!,
                              attributeProvider.attributesResponseModel.jsonResponse!.attributes![4].options!,
                              'garage',
                              attributeProvider
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical*1,),
                        ShadowFlexContainer(
                          radius: 0,
                          child: buildCheckboxGroup(
                              attributeProvider.attributesResponseModel.jsonResponse!.attributes![5].title!,
                              attributeProvider.attributesResponseModel.jsonResponse!.attributes![5].options!,
                              'outdoor',
                              attributeProvider
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical*1,),
                        ShadowFlexContainer(
                          radius: 0,
                          child: buildTextField(
                              attributeProvider.attributesResponseModel.jsonResponse!.attributes![6].title!,
                              'preferredTime',
                              attributeProvider
                          ),
                        ),
                        ShadowFlexContainer(
                          radius: 0,
                          child: Padding(
                              padding: EdgeInsets.all(SizeConfig.blockSizeVertical*1),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate()){
                                    if(attributeProvider.selectedGarage==null){
                                      showScaffoldMessage(context, 'Select an option of Garage cleaning');
                                    }
                                    else if(attributeProvider.selectedOutdoor==null){
                                      showScaffoldMessage(context, 'Selecting Outdoor Area is required');
                                    }
                                    else if(attributeProvider.selectedCleaningFrequency==null){
                                      showScaffoldMessage(context, 'Selecting  cleaning frequency is required');
                                    }
                                    else if(attributeProvider.selectedBathrooms==null){
                                      showScaffoldMessage(context, 'Selecting  bathrooms is required');
                                    }
                                    else if(attributeProvider.selectedBedrooms==null){
                                      showScaffoldMessage(context, 'Selecting bedroom is required');
                                    }
                                    else if(attributeProvider.selectedPropertyType==null){
                                      showScaffoldMessage(context, 'Selecting property is required');
                                    }
                                    else{
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  InputSummaryScreen()),
                                      );
                                    }

                                  }
                                  else{
                                    showScaffoldMessage(context, "You need to validate the Form");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: Colors.green, // Set the text color to white
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20), // Optional padding
                                ),
                                child: const Text('Submit'),
                              ),
                            ),
                          )
                        ),


                      ],
                    ) )



        )
      ),

    );
  }
  Widget buildRadioGroup(String title, List<String> options, String field, AllAttributeDetailsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:EdgeInsets.only(
              left:SizeConfig.blockSizeHorizontal*6.10,
              bottom:SizeConfig.blockSizeVertical*2.10,
              top: SizeConfig.blockSizeVertical * 2.10

          ),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.blockSizeVertical*2)),
        ),
        ...options.map((option) => ShadowFlexContainer(
          radius: 0,
          child: RadioListTile(
            title: Text(option),
            value: option,
            groupValue:field=='propertyType'? provider.selectedPropertyType:provider.selectedCleaningFrequency,
            onChanged: (value) => provider.updateValue(field, value),
          ),
        )),
        SizedBox(height: SizeConfig.blockSizeVertical*1.7),
      ],
    );
  }
  Widget buildDropdown(String title, List<String> options, String field, AllAttributeDetailsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.blockSizeVertical*2)),
        SizedBox(height: SizeConfig.blockSizeVertical*1),
        DropdownButtonFormField<String>(
          value: field == 'bedrooms' ? provider.selectedBedrooms : provider.selectedBathrooms,
          items: options.map((option) => DropdownMenuItem(
              value: option, child: Text(option))).toList(),
          hint: Text(field == 'bedrooms' ?
          '${(provider.selectedBedrooms??0)} bedroom':'${(provider.selectedBathrooms??0)} Bathroom'),
          onChanged: (value) => provider.updateValue(field, value),
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical*2.5),
      ],
    );
  }
  Widget buildCheckboxGroup(String title, List<String> options, String field, AllAttributeDetailsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 6.10,
            bottom: SizeConfig.blockSizeVertical * 2.10,
            top: SizeConfig.blockSizeVertical * 2.10,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockSizeVertical * 2,
            ),
          ),
        ),

        CheckboxListTile(
          title: Text(options[0]),
          value: field=='garage'?provider.selectedGarage == options[0]:
                provider.selectedOutdoor == options[0],
          onChanged: (bool? value) {
            if (value == true) {
              provider.updateValue(field, options[0]);
            }
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          title: Text(options[1]),
          value: field=='garage'?provider.selectedGarage == options[1]:
          provider.selectedOutdoor == options[1],
          onChanged: (bool? value) {
            if (value == true) {
              provider.updateValue(field, options[1]);
            }
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 1.7),
      ],
    );
  }
  Widget buildTextField(String title, String field, AllAttributeDetailsProvider provider) {
    return Padding(
      padding:  EdgeInsets.all(SizeConfig.blockSizeVertical*2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.blockSizeVertical*2)),
          SizedBox(height: SizeConfig.blockSizeVertical*2,),
          TextFormField(
            onChanged: (value) => provider.updateValue(field, value),
            decoration: const InputDecoration(
                fillColor: Colors.grey,
                border: OutlineInputBorder(), hintText: 'Type here...'),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }


}
