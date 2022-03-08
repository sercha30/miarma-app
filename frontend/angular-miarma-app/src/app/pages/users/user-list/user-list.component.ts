import { Component, OnInit } from '@angular/core';
import { UserResponse } from 'src/app/models/interfaces/user';
import { UsersService } from 'src/app/services/users.service';

@Component({
  selector: 'app-user-list',
  templateUrl: './user-list.component.html',
  styleUrls: ['./user-list.component.css'],
})
export class UserListComponent implements OnInit {
  users!: UserResponse[];

  constructor(private userService: UsersService) {}

  ngOnInit(): void {
    this.userService.getAllUsers().subscribe((result) => {
      this.users = result;
    });
  }
}
