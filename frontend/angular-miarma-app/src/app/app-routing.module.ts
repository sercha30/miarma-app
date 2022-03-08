import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './pages/login/login.component';
import { NoPostsComponent } from './pages/posts/no-posts/no-posts.component';
import { PostsComponent } from './pages/posts/posts.component';
import { UserListComponent } from './pages/users/user-list/user-list.component';

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'posts', component: PostsComponent },
  { path: 'no-posts', component: NoPostsComponent },
  { path: 'users', component: UserListComponent },
  { path: '', redirectTo: 'login', pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
