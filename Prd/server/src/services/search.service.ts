import { Injectable } from '@nestjs/common';
import { SAMPLE_COMMUNITIES, SAMPLE_EVENTS, SAMPLE_NEWS, SAMPLE_PUBLICATIONS, SAMPLE_SERMONS } from '../data/sample';
import { paginate, PaginatedResult } from '../utils/paginate';

export type SearchItemType = 'sermon' | 'news' | 'event' | 'community' | 'publication';

export interface SearchItem {
  type: SearchItemType;
  id: string;
  title: string;
  summary?: string;
  publishedAt?: string;
  startAt?: string;
}

const includesIgnoreCase = (text: string, query: string) =>
  text.toLowerCase().includes(query.toLowerCase());

@Injectable()
export class SearchService {
  search(params: {
    q?: string;
    types?: SearchItemType[];
    language?: string;
    cursor?: string;
    limit: number;
  }): PaginatedResult<SearchItem> {
    const query = params.q?.trim();
    if (!query) {
      return paginate([], params.cursor, params.limit);
    }

    const types = params.types?.length ? params.types : ['sermon', 'news', 'event', 'community', 'publication'];
    const results: SearchItem[] = [];

    if (types.includes('sermon')) {
      SAMPLE_SERMONS.filter((s) => (params.language ? s.language === params.language : true))
        .filter((s) => includesIgnoreCase(s.title, query) || includesIgnoreCase(s.summary, query))
        .forEach((s) =>
          results.push({
            type: 'sermon',
            id: s.id,
            title: s.title,
            summary: s.summary,
            publishedAt: s.publishedAt,
          }),
        );
    }

    if (types.includes('news')) {
      SAMPLE_NEWS.filter((n) => (params.language ? n.language === params.language : true))
        .filter((n) => includesIgnoreCase(n.title, query) || includesIgnoreCase(n.summary, query))
        .forEach((n) =>
          results.push({
            type: 'news',
            id: n.id,
            title: n.title,
            summary: n.summary,
            publishedAt: n.publishedAt,
          }),
        );
    }

    if (types.includes('event')) {
      SAMPLE_EVENTS.filter((e) => includesIgnoreCase(e.title, query) || includesIgnoreCase(e.summary, query))
        .forEach((e) =>
          results.push({
            type: 'event',
            id: e.id,
            title: e.title,
            summary: e.summary,
            startAt: e.startAt,
          }),
        );
    }

    if (types.includes('community')) {
      SAMPLE_COMMUNITIES.filter((c) => includesIgnoreCase(c.name, query) || includesIgnoreCase(c.address, query))
        .forEach((c) =>
          results.push({
            type: 'community',
            id: c.id,
            title: c.name,
            summary: c.address,
          }),
        );
    }

    if (types.includes('publication')) {
      SAMPLE_PUBLICATIONS.filter((p) => (params.language ? p.language === params.language : true))
        .filter((p) => includesIgnoreCase(p.title, query) || includesIgnoreCase(p.issue, query))
        .forEach((p) =>
          results.push({
            type: 'publication',
            id: p.id,
            title: p.title,
            summary: p.issue,
            publishedAt: p.publishedAt,
          }),
        );
    }

    const sorted = results.sort((a, b) => {
      const left = a.publishedAt || a.startAt || '';
      const right = b.publishedAt || b.startAt || '';
      return right.localeCompare(left);
    });

    return paginate(sorted, params.cursor, params.limit);
  }
}
