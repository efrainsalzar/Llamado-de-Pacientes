import { bootstrapApplication } from '@angular/platform-browser';
import { App } from './app/app';
import { importProvidersFrom } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';

bootstrapApplication(App, {
  providers: [
    importProvidersFrom(HttpClientModule),
    // aquí puedes agregar appConfig si quieres usarlo como provider
  ]
})
.catch(err => console.error(err));
