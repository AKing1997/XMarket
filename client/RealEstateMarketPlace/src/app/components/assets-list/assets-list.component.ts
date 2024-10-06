import { Component, OnInit } from '@angular/core';
import { TronWebService } from 'src/app/services/tronweb.service';

@Component({
  selector: 'app-assets-list',
  templateUrl: './assets-list.component.html',
  styleUrls: ['./assets-list.component.css']
})
export class AssetsListComponent implements OnInit {
  public assets: any[] = [];

  constructor(private tronWebService: TronWebService) { }

  ngOnInit(): void {
    this.loadAssets();
  }

  async loadAssets() {
    // Cargar los activos desde la blockchain
    const tokenIds = [1, 2, 3]; // Aquí deberías obtener los IDs de los activos de manera dinámica
    for (const tokenId of tokenIds) {
      const asset = await this.tronWebService.getAsset(tokenId);
      this.assets.push(asset);
    }
  }
}
