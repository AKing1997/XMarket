import { Injectable } from '@angular/core';
import {TronWeb} from 'tronweb'; // Ensure proper import
import RealEstateAssetABI from './../../contracts/RealEstateAsset.json'; // Adjust path if necessary

// Define the interface for the RealEstateAsset contract based on the ABI
interface RealEstateAssetContract {
  registerAsset(assetId: string, assetData: string): Promise<{ transaction: any }>; // Update to return the transaction object
  getAssetInfo(assetId: string): Promise<any>; // This can return whatever the contract returns
}

@Injectable({
  providedIn: 'root'
})
export class RealEstateAssetService {
  private tronWeb: TronWeb;
  private contractAddress = 'TXDqbGMwwfvb5iwhrXvGjQwpaCcRGXnXNw'; // RealEstateAsset contract address

  constructor() {
    this.tronWeb = new TronWeb({
      fullHost: 'https://api.shasta.trongrid.io',
      privateKey: 'your-private-key-here'
    });
  }

  // // Function to register a new asset
  // async registerAsset(assetId: string, assetData: string): Promise<any> {
  //   // Obtain the contract instance
  //   const contract = await this.tronWeb.contract(RealEstateAssetABI.abi, this.contractAddress) as unknown as RealEstateAssetContract;

  //   // Call the method and return the transaction result
  //   return await contract.registerAsset(assetId, assetData).send(); // Ensure to await the send() method
  // }

  // Function to get asset information
  // async getAssetInfo(assetId: string): Promise<any> {
  //   // Obtain the contract instance
  //   const contract = await this.tronWeb.contract(RealEstateAssetABI.abi, this.contractAddress) as unknown as RealEstateAssetContract;

  //   // Call the method and return the result
  //   return await contract.getAssetInfo(assetId).call(); // Ensure to await the call() method
  // }
}
