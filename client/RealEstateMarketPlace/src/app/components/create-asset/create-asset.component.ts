import { Component } from '@angular/core';
import { TronWebService } from '../../services/tronweb.service';
@Component({
  selector: 'app-create-asset',
  templateUrl: './create-asset.component.html',
  styleUrls: ['./create-asset.component.css']
})
export class CreateAssetComponent {
  public assetName: string = '';
  public location: string = '';
  public value: number = 0;

  constructor(private tronWebService: TronWebService) {}

  async createAsset() {
    if (this.assetName && this.location && this.value) {
      await this.tronWebService.createAsset(this.assetName, this.location, this.value);
      alert('¡Activo creado con éxito!');
    } else {
      alert('Por favor, rellena todos los campos.');
    }
  }
}
