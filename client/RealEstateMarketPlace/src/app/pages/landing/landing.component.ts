import { Component } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-landing',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './landing.component.html',
  styleUrls: ['./landing.component.sass']
})
export class LandingComponent {
  currentAddress: string | null = null;

  constructor(private authService: AuthService) {
    this.authService.currentAddress$.subscribe(address => {
      this.currentAddress = address;
    });
  }

  connect() {
    this.authService.connect().catch(console.error);
  }

  disconnect() {
    this.authService.disconnect().catch(console.error);
  }

  signMessage() {
    this.authService.signMessage('Hello, Tron!').then(signature => {
      console.log('Signed Message:', signature);
    }).catch(console.error);
  }

  signTransaction() {
    const transaction = {
      // Your transaction object
    };

    this.authService.signTransaction(transaction).then(result => {
      console.log('Signed Transaction:', result);
    }).catch(console.error);
  }
}