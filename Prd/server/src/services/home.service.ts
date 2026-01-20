import { Injectable } from '@nestjs/common';
import { SAMPLE_EVENTS } from '../data/sample';
import { SermonsService } from './sermons.service';
import { NewsService } from './news.service';
import { CommunitiesService } from './communities.service';

@Injectable()
export class HomeService {
  constructor(
    private readonly sermons: SermonsService,
    private readonly news: NewsService,
    private readonly communities: CommunitiesService,
  ) {}

  getHome() {
    const latestSermons = this.sermons.list({ limit: 5, cursor: undefined }).items;
    const latestNews = this.news.list({ limit: 3, cursor: undefined }).items;
    const upcomingEvents = SAMPLE_EVENTS.slice(0, 3);
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
      adSlot: { placement: 'home_bottom', creativeId: 'stub-ad-001' },
    };
  }
}
