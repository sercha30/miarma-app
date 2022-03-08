import { Component, Input, OnInit } from '@angular/core';
import { PostResponse } from 'src/app/models/interfaces/post';
import { PostsService } from 'src/app/services/posts.service';

@Component({
  selector: 'app-post-item',
  templateUrl: './post-item.component.html',
  styleUrls: ['./post-item.component.css'],
})
export class PostItemComponent implements OnInit {
  @Input() postInput!: PostResponse;

  constructor(private postService: PostsService) {}

  ngOnInit(): void {}

  deletePost() {
    this.postService.deletePost(this.postInput.id).subscribe((result) => {
      window.location.reload();
    });
  }
}
