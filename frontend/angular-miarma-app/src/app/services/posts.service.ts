import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { PostResponse } from '../models/interfaces/post';

const POSTS_BASE_URL = 'post';
const DEFAULT_HEADERS = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${localStorage.getItem('BEARER_TOKEN')}`,
  }),
};

@Injectable({
  providedIn: 'root',
})
export class PostsService {
  constructor(private http: HttpClient) {}

  getAllPosts(): Observable<PostResponse[]> {
    let requestUrl = `${environment.apiBaseUrl}${POSTS_BASE_URL}/admin/all`;
    return this.http.get<PostResponse[]>(requestUrl, DEFAULT_HEADERS);
  }

  deletePost(postId: string) {
    let requestUrl = `${environment.apiBaseUrl}${POSTS_BASE_URL}/admin/${postId}`;
    return this.http.delete(requestUrl, DEFAULT_HEADERS);
  }
}
