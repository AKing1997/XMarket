import { Injectable } from '@angular/core';
import { TronLinkAdapter } from '@tronweb3/tronwallet-adapters';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private adapter: TronLinkAdapter | null = null;
  private currentAddressSubject = new BehaviorSubject<string | null>(null);
  public currentAddress$ = this.currentAddressSubject.asObservable();

  constructor() {
    this.initializeAdapter();
    this.loadCurrentAddress();
  }

  private async initializeAdapter() {
    this.adapter = new TronLinkAdapter();

    this.adapter.on('connect', (address: string) => {
      console.log('Connected to address:', address);
      this.setCurrentAddress(address);
    });

    this.adapter.on('disconnect', () => {
      console.log('Disconnected');
      this.setCurrentAddress(null);
    });
  }

  private loadCurrentAddress() {
    const address = localStorage.getItem('currentAddress');
    if (address) {
      this.currentAddressSubject.next(address);
    }
  }

  private setCurrentAddress(address: string | null) {
    if (address) {
      localStorage.setItem('currentAddress', address);
    } else {
      localStorage.removeItem('currentAddress');
    }
    this.currentAddressSubject.next(address);
  }

  private async getConnectedAddress(): Promise<string | null> {
    if (this.adapter) {
      try {
        return await this.adapter.address; // Método para obtener la dirección
      } catch (error) {
        console.error('Error getting address:', error);
        return null;
      }
    }
    return null;
  }

  async connect() {
    if (!this.adapter) throw new Error('Adapter not initialized');
    await this.adapter.connect();
  }

  async disconnect() {
    if (!this.adapter) throw new Error('Adapter not initialized');
    await this.adapter.disconnect();
    this.setCurrentAddress(null);
  }

  async signMessage(message: string) {
    if (!this.adapter) throw new Error('Adapter not initialized');
    return this.adapter.signMessage(message);
  }

  async signTransaction(transaction: any) {
    if (!this.adapter) throw new Error('Adapter not initialized');
    return this.adapter.signTransaction(transaction);
  }
}