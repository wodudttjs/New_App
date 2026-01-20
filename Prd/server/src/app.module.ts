import { Module } from '@nestjs/common';
import { HomeController } from './controllers/home.controller';
import { SermonsController } from './controllers/sermons.controller';
import { NewsController } from './controllers/news.controller';
import { CommunitiesController } from './controllers/communities.controller';
import { PublicationsController } from './controllers/publications.controller';
import { SermonsService } from './services/sermons.service';
import { NewsService } from './services/news.service';
import { CommunitiesService } from './services/communities.service';
import { PublicationsService } from './services/publications.service';
import { HomeService } from './services/home.service';

@Module({
  imports: [],
  controllers: [
    HomeController,
    SermonsController,
    NewsController,
    CommunitiesController,
    PublicationsController,
  ],
  providers: [
    SermonsService,
    NewsService,
    CommunitiesService,
    PublicationsService,
    HomeService,
  ],
})
export class AppModule {}
