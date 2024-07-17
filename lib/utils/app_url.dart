class AppUrl {
  static String baseUrl = 'https://jsonplaceholder.typicode.com';
  static String allPosts = '$baseUrl/posts';
  static String commentsForPost(String postId) => '$allPosts/$postId/comments';
}
