import { Injectable } from '@nestjs/common';
import { SermonsService } from './sermons.service';
import { NewsService } from './news.service';
import { CommunitiesService } from './communities.service';
import { EventsService } from './events.service';
import { AdsService } from './ads.service';

@Injectable()
export class HomeService {
  constructor(
    private readonly sermons: SermonsService,
    private readonly news: NewsService,
    private readonly communities: CommunitiesService,
    private readonly events: EventsService,
    private readonly ads: AdsService,
  ) {}

  getHome() {
    const latestSermons = this.sermons.list({ limit: 5, cursor: undefined }).items;
    const latestNews = this.news.list({ limit: 3, cursor: undefined }).items;
    const upcomingEvents = this.events.list({ limit: 3, cursor: undefined }).items;
    const communityShortcut = {
      label: '가까운 커뮤니티 찾기',
      deeplink: 'app://communities',
    };

    return {
      hero: {
        quote: "God's dream, one family.",
        subtitle: '오늘의 묵상을 조용히 시작하세요.',
      },
      latestSermons,
      latestNews,
      upcomingEvents,
      communityShortcut,
      adSlot: this.ads.getSlots('home')[0] ?? null,
    };
  }
}
