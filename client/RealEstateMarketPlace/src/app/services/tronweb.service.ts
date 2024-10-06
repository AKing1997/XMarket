import { Injectable } from '@angular/core';
import { TronWeb, utils as TronWebUtils, Trx, TransactionBuilder, Contract, Event, Plugin } from 'tronweb';

interface TronLink {
  request: (params: { method: 'tron_requestAccounts' }) => Promise<string[]>;
}

@Injectable({
  providedIn: 'root'
})
export class TronwebService {
  private tronWeb: TronWeb;
  private privateKey: string = 'f6cd09b8-29b1-4012-9d40-88bd40635401'; // Considera manejar el privateKey de forma más segura
  public userAddress: string | null = null; // Para almacenar la dirección del usuario
  private tronLink: TronLink | undefined = (window as any)['tronLink'];

  constructor() {
    this.tronWeb = new TronWeb({
      fullHost: 'https://api.shasta.trongrid.io',
      headers: { 'TRON-PRO-API-KEY': this.privateKey },
      privateKey: this.privateKey
    });
  }

  // Método para conectarse a TronLink
  async connectWallet(): Promise<void> {
    if (this.tronLink) {
      try {
        // Solicitar conexión con TronLink
        const result = await this.tronLink.request({ method: 'tron_requestAccounts' });
        this.userAddress = result[0]; // Almacenar la dirección del usuario
      } catch (error) {
        console.error('Error al conectar con TronLink:', error);
        throw new Error('No se pudo conectar con TronLink.');
      }
    } else {
      throw new Error('TronLink no está instalado.');
    }
  }

  // Función para obtener el saldo en TRX de una dirección
  async getBalance(address: string): Promise<number> {
    try {
      const balance = await this.tronWeb.trx.getBalance(address);
      return balance;
    } catch (error) {
      console.error('Error obteniendo balance:', error);
      throw error;
    }
  } 
}