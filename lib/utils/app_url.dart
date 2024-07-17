class AppUrl {
  static String baseUrl = 'https://jsonplaceholder.typicode.com';

  static String allPosts = '$baseUrl/posts';
  static String commentsForPost(String postId) => '$allPosts/$postId/comments';
  static String allUsers = "$baseUrl/users";
  static String allAlbums = "$baseUrl/albums";
}
