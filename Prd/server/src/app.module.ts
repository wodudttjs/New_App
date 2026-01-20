import { Module } from '@nestjs/common';
import { HomeController } from './controllers/home.controller';
import { SermonsController } from './controllers/sermons.controller';
import { NewsController } from './controllers/news.controller';
import { CommunitiesController } from './controllers/communities.controller';
import { PublicationsController } from './controllers/publications.controller';
import { EventsController } from './controllers/events.controller';
import { SearchController } from './controllers/search.controller';
import { PushController } from './controllers/push.controller';
import { AdsController } from './controllers/ads.controller';
import { SermonsService } from './services/sermons.service';
import { NewsService } from './services/news.service';
import { CommunitiesService } from './services/communities.service';
import { PublicationsService } from './services/publications.service';
import { HomeService } from './services/home.service';
import { EventsService } from './services/events.service';
import { SearchService } from './services/search.service';
import { PushService } from './services/push.service';
import { AdsService } from './services/ads.service';

@Module({
  imports: [],
  controllers: [
    HomeController,
    SermonsController,
    NewsController,
    CommunitiesController,
    PublicationsController,
    EventsController,
    SearchController,
    PushController,
    AdsController,
  ],
  providers: [
    SermonsService,
    NewsService,
    CommunitiesService,
    PublicationsService,
    HomeService,
    EventsService,
    SearchService,
    PushService,
    AdsService,
  ],
})
export class AppModule {}
