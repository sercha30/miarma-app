import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialImportsModule } from './modules/material-imports/material-imports.module';
import { LoginComponent } from './pages/login/login.component';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { PostsComponent } from './pages/posts/posts.component';
import { PostItemComponent } from './pages/posts/post-item/post-item.component';
import { NoPostsComponent } from './pages/posts/no-posts/no-posts.component';
import { UserListComponent } from './pages/users/user-list/user-list.component';
import { UserItemComponent } from './pages/users/user-item/user-item.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    PostsComponent,
    PostItemComponent,
    NoPostsComponent,
    UserListComponent,
    UserItemComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialImportsModule,
    ReactiveFormsModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
