import { Controller, Get } from '@nestjs/common';
import { HomeService } from '../services/home.service';

@Controller('home-feed')
export class HomeController {
  constructor(private readonly homeService: HomeService) {}

  @Get()
  getHome() {
    return this.homeService.getHome();
  }
}
