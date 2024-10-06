// import { Component } from '@angular/core';

// @Component({
//   selector: 'app-transfer-asset',
//   templateUrl: './transfer-asset.component.html',
//   styleUrls: ['./transfer-asset.component.css']
// })
// export class TransferAssetComponent {
//   public fromAddress: string = '';
//   public toAddress: string = '';
//   public tokenId: number = 0;

//   constructor(private tronWebService: TronWebService) {}

//   async transferAsset() {
//     if (this.fromAddress && this.toAddress && this.tokenId) {
//       await this.tronWebService.transferAsset(this.fromAddress, this.toAddress, this.tokenId);
//       alert('¡Activo transferido con éxito!');
//     } else {
//       alert('Por favor, rellena todos los campos.');
//     }
//   }
// }
