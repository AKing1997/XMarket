import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { map, take } from 'rxjs/operators';
import { AuthService } from '../services/auth.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {
  constructor(private authService: AuthService, private router: Router) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean> | Promise<boolean> | boolean {
    return this.authService.currentAddress$.pipe(
      take(1), // Asegúrate de completar la suscripción después de obtener el valor
      map(address => {
        console.log('Current Address in AuthGuard:', address); // Para depuración
        if (address) {
          return true; // Usuario conectado
        } else {
          console.log('Redirecting to login'); // Para depuración
          this.router.navigate(['/']); // Redirigir a inicio de sesión si no está conectado
          return false; // Usuario no conectado
        }
      })
    );
  }
}
