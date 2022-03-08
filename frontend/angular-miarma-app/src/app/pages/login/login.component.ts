import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthLoginDto } from 'src/app/models/auth.dto';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {
  loginDto = new AuthLoginDto();
  loginForm = new FormGroup({
    email: new FormControl('', [Validators.required, Validators.email]),
    password: new FormControl('', Validators.required),
  });

  constructor(private authService: AuthService, private router: Router) {}

  ngOnInit(): void {}

  getErrorMessage() {
    if (this.loginForm.controls['email'].hasError('required')) {
      return 'Debe introducir su email';
    } else if (this.loginForm.controls['email'].hasError('email')) {
      return 'Email no válido';
    } else {
      return 'Debe introducir su contraseña';
    }
  }

  doLogin() {
    this.loginDto.email = this.loginForm.get('email')?.value;
    this.loginDto.password = this.loginForm.get('password')?.value;
    this.authService.login(this.loginDto).subscribe((loginResult) => {
      localStorage.setItem('BEARER_TOKEN', loginResult.token);
      console.log(localStorage.getItem('BEARER_TOKEN'));
      this.router.navigate(['/posts']);
    });
  }
}
