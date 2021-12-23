import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:india_today_task/core/constants/app_colors.dart';
import 'package:india_today_task/core/models/models.dart';
import 'package:india_today_task/core/view_models/home_view_models.dart';
import 'package:india_today_task/ui/my_stream_builder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class Home extends ViewModelWidget<HomeViewModel> {
  const Home({Key key}) : super(key: key);

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Icon(LineIcons.bars),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Daily Panchang".text.textStyle(context.textTheme.subtitle1).bold.make(),
            8.heightBox,
            loremIpsum(words: 50).text.textStyle(context.textTheme.bodyText1).maxLines(3).make(),
            8.heightBox,
            Container(
              color: AppColors.containerColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Table(
                    columnWidths: const{
                      0: FractionColumnWidth(.25),
                      1: FractionColumnWidth(.75),
                    },
                    children: [
                      TableRow(
                        children: [
                          "Date:".text.textStyle(context.textTheme.bodyText1).makeCentered().pSymmetric(v: 24),
                          TextField(
                            controller: model.dateEditingController,
                            readOnly: true,
                            onTap: () => model.openDatePicker(context),
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                )
                            ),
                          ).p(8)
                        ]
                      ),
                      TableRow(
                        children: [
                          "Location:".text.textStyle(context.textTheme.bodyText1).makeCentered().pSymmetric(v: 24),
                          TypeAheadField(
                            onSuggestionSelected: (Places suggestion) {
                              model.locationEditingController.text = suggestion.placeName;
                              model.setPlaceId(suggestion.placeId);
                            },
                            itemBuilder: (context, Places suggestion) {
                              debugPrint(suggestion.toJson().toString());
                              return ListTile(
                                title: Text(suggestion.placeName),
                              );
                            },
                            suggestionsCallback: (pattern) async{
                              if(pattern.trim().isNotEmpty) {
                                return await model.getCities(pattern);
                              }
                              return null;
                            },
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: model.locationEditingController,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                                )
                              )
                            ),
                          ).p(8)
                        ]
                      )
                    ],
                  ),
                ],
              ),
            ),
            8.heightBox,
            MyStreamBuilder<PanchangModel>(
              stream: model.panchang,
              loadingChild: const SizedBox.shrink(),
              onDataWidget: (PanchangModel data){
                if(data.tithi == null)
                  return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Tithi".text.textStyle(context.textTheme.subtitle1).bold.make(),
                    8.heightBox,
                    Table(
                      children: [
                        TableRow(
                          children: [
                            "Thithi Number:".text.textStyle(context.textTheme.caption).make(),
                            data.tithi.details.tithiNumber.text.textStyle(context.textTheme.caption).make()
                          ]
                        ),
                        TableRow(
                          children: [
                            8.heightBox,
                            8.heightBox,
                          ]
                        ),
                        TableRow(
                          children: [
                            "Thithi Name:".text.textStyle(context.textTheme.caption).make(),
                            data.tithi.details.tithiName.text.textStyle(context.textTheme.caption).make()
                          ]
                        ),
                        TableRow(
                            children: [
                              8.heightBox,
                              8.heightBox,
                            ]
                        ),
                        TableRow(
                          children: [
                            "Special:".text.textStyle(context.textTheme.caption).make(),
                            data.tithi.details.special.text.textStyle(context.textTheme.caption).make()
                          ]
                        ),
                        TableRow(
                            children: [
                              8.heightBox,
                              8.heightBox,
                            ]
                        ),
                        TableRow(
                          children: [
                            "Summary:".text.textStyle(context.textTheme.caption).make(),
                            data.tithi.details.summary.text.textStyle(context.textTheme.caption).maxLines(3).make()
                          ]
                        ),
                        TableRow(
                            children: [
                              8.heightBox,
                              8.heightBox,
                            ]
                        ),
                        TableRow(
                          children: [
                            "Deity:".text.textStyle(context.textTheme.caption).make(),
                            data.tithi.details.deity.text.textStyle(context.textTheme.caption).make()
                          ]
                        ),
                        TableRow(
                            children: [
                              8.heightBox,
                              8.heightBox,
                            ]
                        ),
                        TableRow(
                          children: [
                            "End Time:".text.textStyle(context.textTheme.caption).make(),
                            "${data.tithi.endTime.hour} hr ${data.tithi.endTime.minute} min ${data.tithi.endTime.second} sec".text.textStyle(context.textTheme.caption).make()
                          ]
                        )
                      ],
                    ),
                    8.heightBox,
                    "Nakshatra".text.textStyle(context.textTheme.subtitle1).bold.make(),
                    8.heightBox,
                    Table(
                      children: [
                        TableRow(
                          children: [
                            "Nakshtra Number:".text.textStyle(context.textTheme.caption).make(),
                            data.nakshatra.details.nakNumber.text.textStyle(context.textTheme.caption).make()
                          ]
                        ),
                        TableRow(
                            children: [
                              8.heightBox,
                              8.heightBox,
                            ]
                        ),
                        TableRow(
                          children: [
                            "Nakshtra Name:".text.textStyle(context.textTheme.caption).make(),
                            data.nakshatra.details.nakName.text.textStyle(context.textTheme.caption).make()
                          ]
                        ),
                        TableRow(
                            children: [
                              8.heightBox,
                              8.heightBox,
                            ]
                        ),
                        TableRow(
                          children: [
                            "Ruler:".text.textStyle(context.textTheme.caption).make(),
                            data.nakshatra.details.ruler.text.textStyle(context.textTheme.caption).make()
                          ]
                        ),
                        TableRow(
                            children: [
                              8.heightBox,
                              8.heightBox,
                            ]
                        ),
                        TableRow(
                          children: [
                            "Summary:".text.textStyle(context.textTheme.caption).make(),
                            data.tithi.details.summary.text.textStyle(context.textTheme.caption).maxLines(3).make()
                          ]
                        ),
                        TableRow(
                            children: [
                              8.heightBox,
                              8.heightBox,
                            ]
                        ),
                        TableRow(
                          children: [
                            "Deity:".text.textStyle(context.textTheme.caption).make(),
                            data.nakshatra.details.deity.text.textStyle(context.textTheme.caption).make()
                          ]
                        ),
                      ],
                    ),
                  ],
                );
              },
              onRefreshClicked: model.getPanchang
            )
          ],
        ).p(16),
      ),
    );
  }
}
