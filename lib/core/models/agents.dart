// To parse this JSON data, do
//
//     final agentModel = agentModelFromJson(jsonString);

import 'dart:convert';

List<AgentModel> agentModelFromJson(String str) => List<AgentModel>.from(json.decode(str).map((x) => AgentModel.fromJson(x)));

String agentModelToJson(List<AgentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AgentModel {
  AgentModel({
    this.id,
    this.urlSlug,
    this.namePrefix,
    this.firstName,
    this.lastName,
    this.aboutMe,
    this.profliePicUrl,
    this.experience,
    this.languages,
    this.minimumCallDuration,
    this.minimumCallDurationCharges,
    this.additionalPerMinuteCharges,
    this.isAvailable,
    this.rating,
    this.skills,
    this.isOnCall,
    this.freeMinutes,
    this.additionalMinute,
    this.images,
    this.availability,
  });

  final int id;
  final String urlSlug;
  final dynamic namePrefix;
  final String firstName;
  final String lastName;
  final String aboutMe;
  final dynamic profliePicUrl;
  final double experience;
  final List<Language> languages;
  final int minimumCallDuration;
  final double minimumCallDurationCharges;
  final double additionalPerMinuteCharges;
  final bool isAvailable;
  final dynamic rating;
  final List<Skill> skills;
  final bool isOnCall;
  final int freeMinutes;
  final int additionalMinute;
  final Images images;
  final Availability availability;

  factory AgentModel.fromJson(Map<String, dynamic> json) => AgentModel(
    id: json["id"],
    urlSlug: json["urlSlug"],
    namePrefix: json["namePrefix"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    aboutMe: json["aboutMe"],
    profliePicUrl: json["profliePicUrl"],
    experience: double.tryParse(json["experience"].toString()),
    languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
    minimumCallDuration: json["minimumCallDuration"],
    minimumCallDurationCharges: double.tryParse(json["minimumCallDurationCharges"].toString()),
    additionalPerMinuteCharges: double.tryParse(json["additionalPerMinuteCharges"].toString()),
    isAvailable: json["isAvailable"],
    rating: json["rating"],
    skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
    isOnCall: json["isOnCall"],
    freeMinutes: json["freeMinutes"],
    additionalMinute: json["additionalMinute"],
    images: Images.fromJson(json["images"]),
    availability: json["availability"] != null ? Availability.fromJson(json["availability"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "urlSlug": urlSlug,
    "namePrefix": namePrefix,
    "firstName": firstName,
    "lastName": lastName,
    "aboutMe": aboutMe,
    "profliePicUrl": profliePicUrl,
    "experience": experience,
    "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
    "minimumCallDuration": minimumCallDuration,
    "minimumCallDurationCharges": minimumCallDurationCharges,
    "additionalPerMinuteCharges": additionalPerMinuteCharges,
    "isAvailable": isAvailable,
    "rating": rating,
    "skills": List<dynamic>.from(skills.map((x) => x.toJson())),
    "isOnCall": isOnCall,
    "freeMinutes": freeMinutes,
    "additionalMinute": additionalMinute,
    "images": images.toJson(),
    "availability": availability != null ? availability.toJson() : null,
  };
}

class Availability {
  Availability({
    this.days,
    this.slot,
  });

  final List<String> days;
  final Slot slot;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    days: json["days"] != null ? List<String>.from(json["days"].map((x) => x)) : null,
    slot: Slot.fromJson(json["slot"]),
  );

  Map<String, dynamic> toJson() => {
    "days": List<dynamic>.from(days.map((x) => x)),
    "slot": slot.toJson(),
  };
}

class Slot {
  Slot({
    this.toFormat,
    this.fromFormat,
    this.from,
    this.to,
  });

  final String toFormat;
  final String fromFormat;
  final String from;
  final String to;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    toFormat: json["toFormat"],
    fromFormat: json["fromFormat"],
    from: json["from"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "toFormat": toFormat,
    "fromFormat": fromFormat,
    "from": from,
    "to": to,
  };
}

class Images {
  Images({
    this.small,
    this.large,
    this.medium,
  });

  final Large small;
  final Large large;
  final Large medium;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    small: Large.fromJson(json["small"]),
    large: Large.fromJson(json["large"]),
    medium: Large.fromJson(json["medium"]),
  );

  Map<String, dynamic> toJson() => {
    "small": small.toJson(),
    "large": large.toJson(),
    "medium": medium.toJson(),
  };
}

class Large {
  Large({
    this.imageUrl,
    this.id,
  });

  final String imageUrl;
  final int id;

  factory Large.fromJson(Map<String, dynamic> json) => Large(
    imageUrl: json["imageUrl"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "id": id,
  };
}

class Language {
  Language({
    this.id,
    this.name,
  });

  final int id;
  final String name;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Skill {
  Skill({
    this.id,
    this.name,
    this.description,
  });

  final int id;
  final String name;
  final String description;

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}
