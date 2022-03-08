import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { UserResponse } from '../models/interfaces/user';

const DEFAULT_HEADERS = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${localStorage.getItem('BEARER_TOKEN')}`,
  }),
};

@Injectable({
  providedIn: 'root',
})
export class UsersService {
  constructor(private http: HttpClient) {}

  getAllUsers(): Observable<UserResponse[]> {
    let requestUrl = `${environment.apiBaseUrl}admin/users`;
    return this.http.get<UserResponse[]>(requestUrl, DEFAULT_HEADERS);
  }

  giveAdmin(userId: string): Observable<UserResponse> {
    let requestUrl = `${environment.apiBaseUrl}admin/user/${userId}/giveAdmin`;
    return this.http.put<UserResponse>(requestUrl, null, DEFAULT_HEADERS);
  }

  removeAdmin(userId: string): Observable<UserResponse> {
    let requestUrl = `${environment.apiBaseUrl}admin/user/${userId}/removeAdmin`;
    return this.http.put<UserResponse>(requestUrl, null, DEFAULT_HEADERS);
  }
}
