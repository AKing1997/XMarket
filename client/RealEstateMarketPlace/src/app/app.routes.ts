import { Routes } from '@angular/router';
import { LandingComponent } from './pages/landing/landing.component';
import { MarketComponent } from './pages/market/market.component';
import { AuthGuard } from './auth/auth.guard';

export const routes: Routes = [
    { path: '', component: LandingComponent },
    { path: 'market', component: MarketComponent, canActivate: [AuthGuard] },
    { path: '**', redirectTo: '' }
];