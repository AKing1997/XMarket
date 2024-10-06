import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TransferAssetComponent } from './transfer-asset.component';

describe('TransferAssetComponent', () => {
  let component: TransferAssetComponent;
  let fixture: ComponentFixture<TransferAssetComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TransferAssetComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TransferAssetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
