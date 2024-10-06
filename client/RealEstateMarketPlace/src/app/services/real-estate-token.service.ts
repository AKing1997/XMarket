import { Injectable } from '@angular/core';
import { TronWeb, utils as TronWebUtils, Trx, TransactionBuilder, Contract, Event, Plugin } from 'tronweb';

@Injectable({
  providedIn: 'root'
})
export class RealEstateTokenService {

  private tronWeb: TronWeb;
  private contractAddress = 'THVysASgtBi78LEiFKefCZrWyD9eF1fyeH'; // RealEstateToken contract address

  constructor() {
    this.tronWeb = new TronWeb({
      fullHost: 'https://api.shasta.trongrid.io',
      privateKey: 'your-private-key-here'
    });
  }

  // // Example: Function to mint a new token
  // async mintToken(to: string, tokenId: string): Promise<any> {
  //   const contract = await this.tronWeb.contract().at(this.contractAddress);
  //   return contract.mint(to, tokenId).send();
  // }

  // // Example: Function to get the owner of a token
  // async ownerOf(tokenId: string): Promise<string> {
  //   const contract = await this.tronWeb.contract().at(this.contractAddress);
  //   return contract.ownerOf(tokenId).call();
  // }
}