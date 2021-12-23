import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:india_today_task/core/constants/app_colors.dart';
import 'package:india_today_task/core/models/agents.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';

class AgentWidget extends StatelessWidget {
  final AgentModel agent;
  const AgentWidget({Key key, @required this.agent}): assert(agent != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: agent.images.large.imageUrl ?? agent.images.medium.imageUrl,
          height: 100,
          width: 100,
          placeholder: (context, _) => Image.asset("assets/logo.png", width: 50, height: 50),
          errorWidget: (context, url, _) => Image.asset("assets/logo.png", width: 50, height: 50),
        ),
        8.widthBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  "${agent.firstName} ${agent.lastName}".text.textStyle(context.textTheme.bodyText1).bold.make(),
                  const Spacer(),
                  if(agent.experience != null)
                    "${agent.experience.toInt()} Years".text.textStyle(context.textTheme.caption).make(),
                ],
              ),
              if(agent.skills != null && agent.skills.isNotEmpty)
              Column(
                children: [
                  4.heightBox,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(LineIcons.userClock, size: 10),
                      8.widthBox,
                      Expanded(
                        child: _getAllNames(agent.toJson()["skills"], "name").text.textStyle(context.textTheme.caption).maxLines(5).make()
                      )
                    ],
                  ),
                ],
              ),
              if(agent.languages != null && agent.languages.isNotEmpty)
                Column(
                  children: [
                    4.heightBox,
                    Row(
                      children: [
                        const Icon(LineIcons.language, size: 10),
                        8.widthBox,
                        _getAllNames(agent.toJson()["languages"], "name").text.textStyle(context.textTheme.caption).make()
                      ],
                    ),
                  ],
                ),
              4.heightBox,
              Row(
                children: [
                  const Icon(LineIcons.clock, size: 10),
                  8.widthBox,
                  Row(
                    children: [
                      const Icon(LineIcons.indianRupeeSign, size: 10, color: Colors.black),
                      "${agent.minimumCallDurationCharges}/min".text.textStyle(context.textTheme.bodyText1).bold.make(),
                    ],
                  )
                ],
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.iconColor),
                ),
                onPressed: (){},
                icon: Icon(LineIcons.phone),
                label: "Talk on Call".text.textStyle(context.textTheme.bodyText1).white.make(),
              )
            ],
          ),
        )
      ],
    );
  }

  String _getAllNames(List<dynamic> list, String keyName){
    return list.map((e) => e[keyName]).toList().join(", ");
  }
}
