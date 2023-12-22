import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  int id;
  String fullName;
  dynamic phone;
  dynamic topicId;
  dynamic email;
  int commentsCount;
  int ratingsCount;
  int acceptedProposalsCount;
  int deniedProposalsCount;
  int proposalsCount;

  UserInfo({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.topicId,
    required this.email,
    required this.commentsCount,
    required this.ratingsCount,
    required this.acceptedProposalsCount,
    required this.deniedProposalsCount,
    required this.proposalsCount,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        fullName: json["full_name"],
        phone: json["phone"],
        topicId: json["topic_id"],
        email: json["email"],
        commentsCount: json["comments_count"],
        ratingsCount: json["ratings_count"],
        acceptedProposalsCount: json["accepted_proposals_count"],
        deniedProposalsCount: json["denied_proposals_count"],
        proposalsCount: json["proposals_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "phone": phone,
        "topic_id": topicId,
        "email": email,
        "comments_count": commentsCount,
        "ratings_count": ratingsCount,
        "accepted_proposals_count": acceptedProposalsCount,
        "denied_proposals_count": deniedProposalsCount,
        "proposals_count": proposalsCount,
      };
}
