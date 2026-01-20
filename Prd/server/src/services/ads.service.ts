import { Injectable } from '@nestjs/common';

export interface AdSlot {
  id: string;
  screen: string;
  placement: string;
  label: string;
}

@Injectable()
export class AdsService {
  private readonly slots: AdSlot[] = [
    { id: 'ad_home_1', screen: 'home', placement: 'home_bottom', label: '홈 하단 네이티브 광고' },
    { id: 'ad_sermon_list_1', screen: 'sermon_list', placement: 'list_bottom', label: '설교 목록 하단 광고' },
    { id: 'ad_news_list_1', screen: 'news_list', placement: 'list_bottom', label: '뉴스 목록 하단 광고' },
  ];

  getSlots(screen: string) {
    return this.slots.filter((slot) => slot.screen === screen);
  }
}
