import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { PostResponse } from 'src/app/models/interfaces/post';
import { PostsService } from 'src/app/services/posts.service';

@Component({
  selector: 'app-posts',
  templateUrl: './posts.component.html',
  styleUrls: ['./posts.component.css'],
})
export class PostsComponent implements OnInit {
  posts!: PostResponse[];

  constructor(private postsService: PostsService, private router: Router) {}

  ngOnInit(): void {
    this.postsService.getAllPosts().subscribe((postsResult) => {
      this.posts = postsResult;
    });
  }
}
