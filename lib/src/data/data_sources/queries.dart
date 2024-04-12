class Queries {
  static String GET_ALL_BLOG_POST = r'''
  query AllBlogPosts {
    allBlogPosts {
      id
      title
      subTitle
      body
      dateCreated
      deleted
    }
  }
''';

static String GET_BLOG_POST = r'''
query getBlog($blogId: String!) {
  blogPost(blogId: $blogId) {
    id
    title
    subTitle
    body
    dateCreated
    deleted
  }
}
''';

static String CREATE_BLOG_POST = r'''
mutation CreateBlog($body: String!, $subTitle: String!, $title: String!) {
  createBlog(body: $body, subTitle: $subTitle, title: $title) {
    success
  }
}
''';

static String UPDATE_BLOG_POST = r'''
mutation UpdateBlog($blogId: String!, $title: String!, $subTitle: String!, $body: String!) {
  updateBlog(blogId: $blogId, title: $title, subTitle: $subTitle, body: $body) {
    blogPost {
      id
      title
      body
      deleted
      dateCreated
      subTitle
    }
  }
}
''';

static String DELETE_BLOG_POST = r'''
mutation DeleteBlog($blogId: String!) {
    deleteBlog(blogId: $blogId) {
        success
    }
}
''';
}


