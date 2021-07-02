class Post {
  String body;
  String author;
  int likes = 0;
  bool userliked = false;

  Post(this.body,this.author);

  void likePost() {
    this.userliked = !this.userliked;
    this.likes = this.userliked ? (this.likes + 1) : (this.likes - 1);
  }
}