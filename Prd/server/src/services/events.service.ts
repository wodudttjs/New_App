import { Injectable } from '@nestjs/common';
import { SAMPLE_EVENTS } from '../data/sample';
import { paginate, PaginatedResult } from '../utils/paginate';

export interface EventItem {
  id: string;
  title: string;
  summary: string;
  startAt: string;
  endAt: string;
  locationName: string;
  address: string;
  regionCode: string;
  tags: string[];
  coverAssetId: string;
  contact: { phone?: string; email?: string; website?: string };
}

@Injectable()
export class EventsService {
  list(params: {
    from?: string;
    to?: string;
    region?: string;
    query?: string;
    cursor?: string;
    limit: number;
  }): PaginatedResult<EventItem> {
    const fromDate = params.from ? new Date(params.from) : undefined;
    const toDate = params.to ? new Date(params.to) : undefined;

    const filtered = SAMPLE_EVENTS.filter((event) => {
      const matchRegion = params.region ? event.regionCode.startsWith(params.region) : true;
      const matchQuery = params.query
        ? event.title.includes(params.query) || event.summary.includes(params.query)
        : true;

      const eventStart = new Date(event.startAt);
      const matchFrom = fromDate ? eventStart >= fromDate : true;
      const matchTo = toDate ? eventStart <= toDate : true;

      return matchRegion && matchQuery && matchFrom && matchTo;
    });

    const sorted = [...filtered].sort((a, b) => a.startAt.localeCompare(b.startAt));
    return paginate(sorted, params.cursor, params.limit);
  }

  detail(id: string): EventItem | undefined {
    return SAMPLE_EVENTS.find((event) => event.id === id);
  }
}
