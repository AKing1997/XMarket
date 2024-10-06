import { Injectable } from '@angular/core';
import { TronWeb, utils as TronWebUtils, Trx, TransactionBuilder, Contract, Event, Plugin } from 'tronweb';

@Injectable({
  providedIn: 'root'
})
export class MarketService {

  private tronWeb: TronWeb;
  private contractAddress = 'TYyptmmn7fP8FkAmPT9QzLTjFTf3pxrbaq'; // Market contract address

  constructor() {
    this.tronWeb = new TronWeb({
      fullHost: 'https://api.shasta.trongrid.io',
      privateKey: 'your-private-key-here'
    });
  }

  // Example: Function to list an asset for sale
  // async listAssetForSale(assetId: string, price: number): Promise<any> {
  //   const contract = await this.tronWeb.contract().at(this.contractAddress);
  //   return contract.listAssetForSale(assetId, price).send();
  // }

  // // Example: Function to purchase an asset
  // async purchaseAsset(assetId: string): Promise<any> {
  //   const contract = await this.tronWeb.contract().at(this.contractAddress);
  //   return contract.purchaseAsset(assetId).send();
  // }
}
