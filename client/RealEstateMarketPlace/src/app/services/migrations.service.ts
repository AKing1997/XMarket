import { Injectable } from '@angular/core';
import { TronWeb, utils as TronWebUtils, Trx, TransactionBuilder, Contract, Event, Plugin } from 'tronweb';

@Injectable({
  providedIn: 'root'
})
export class MigrationsService {

  private tronWeb: TronWeb;
  private contractAddress = 'TDoxmTzZZts9tuRQ9nTjxdNYAcPH368RHA'; // Migrations contract address

  constructor() {
    this.tronWeb = new TronWeb({
      fullHost: 'https://api.shasta.trongrid.io',
      privateKey: 'your-private-key-here'
    });
  }

  // Example: Function to get contract owner
  // async getOwner(): Promise<string> {
  //   const contract = await this.tronWeb.contract().at(this.contractAddress);
  //   return contract.owner().call();
  // }
}