class Community {
  final String name;
  final String description;
  final bool adult;
  final String community_icon_image;
  final String subreddit_alt;
  final String subreddit_background_name;
  final List<String> members;

  Community({required this.name, required this.description, required this.adult,required this.community_icon_image, required this.subreddit_alt, required this.subreddit_background_name, required this.members});
}