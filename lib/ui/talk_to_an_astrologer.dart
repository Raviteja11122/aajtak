import 'package:india_today_task/core/constants/app_colors.dart';
import 'package:india_today_task/core/models/models.dart';
import 'package:india_today_task/core/view_models/home_view_models.dart';
import 'package:india_today_task/ui/widgets/agent_widget.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'my_stream_builder.dart';

class TalkToAstrologer extends ViewModelWidget<HomeViewModel>{
  const TalkToAstrologer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Talk to an Astrologer".text.textStyle(context.textTheme.subtitle1).bold.make(),
            Row(
              children: [
                InkWell(
                  child: Image.asset("assets/search.png", height: 20),
                  onTap: model.toggleSearch,
                ),
                8.widthBox,
                InkWell(
                  child: Image.asset("assets/filter.png", height: 20),
                  onTap: (){},
                ),
                8.widthBox,
                PopupMenuButton<int>(
                  onSelected: model.setSortBy,
                  child: Image.asset("assets/sort.png", height: 20),
                  itemBuilder: (_) => <PopupMenuEntry<int>>[
                    PopupMenuItem(enabled: false, value: 100, child: "Sort By".text.isIntrinsic.textStyle(context.textTheme.caption).color(AppColors.iconColor).make()),
                    const PopupMenuDivider(height: 2),
                    for(var key in model.sortByOptions.keys)
                      CheckedPopupMenuItem<int>(
                        value: key,
                        checked: key == model.sortBy,
                        child: model.sortByOptions[key].toString().text.isIntrinsic.make()
                      ),
                  ]
                ),
              ],
            )
          ],
        ),
        8.heightBox,
        if(model.enableSearch)
          TextField(
            controller: model.searchEditingController,
            onChanged: (val) => model.filterAgents(),
            decoration: InputDecoration(
              hintText: "Search",
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.iconColor),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.iconColor),
              ),
              prefixIcon: const Icon(LineIcons.search, color: AppColors.iconColor),
              suffixIcon: IconButton(
                onPressed: (){
                  model.searchEditingController.text = "";
                  model.filterAgents();
                },
                icon: const Icon(LineIcons.times, color: AppColors.iconColor)
              )
            ),
          ),
        8.heightBox,
        Expanded(
          child: MyStreamBuilder<List<AgentModel>>(
            stream: model.agents,
            loadingChild: const SizedBox.shrink(),
            onDataWidget: (List<AgentModel> data){
              if(data.isEmpty)
                return const SizedBox.shrink();
              return ListView.separated(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => AgentWidget(agent: data[index]),
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              );
            },
            onRefreshClicked: model.getPanchang
          ),
        )
      ],
    ).p(8);
  }
}