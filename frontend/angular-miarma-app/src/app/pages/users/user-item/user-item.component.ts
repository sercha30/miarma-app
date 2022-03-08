import { Component, Input, OnInit } from '@angular/core';
import { UserResponse } from 'src/app/models/interfaces/user';
import { UsersService } from 'src/app/services/users.service';

@Component({
  selector: 'app-user-item',
  templateUrl: './user-item.component.html',
  styleUrls: ['./user-item.component.css'],
})
export class UserItemComponent implements OnInit {
  @Input() userInput!: UserResponse;

  constructor(private userService: UsersService) {}

  ngOnInit(): void {}

  giveAdmin() {
    this.userService.giveAdmin(this.userInput.id).subscribe((result) => {
      window.location.reload();
    });
  }

  removeAdmin() {
    this.userService.removeAdmin(this.userInput.id).subscribe((result) => {
      window.location.reload();
    });
  }
}
