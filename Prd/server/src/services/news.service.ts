import { Injectable } from '@nestjs/common';
import { SAMPLE_NEWS } from '../data/sample';
import { paginate, PaginatedResult } from '../utils/paginate';

export interface NewsItem {
  id: string;
  category: 'notice' | 'news' | 'column' | string;
  title: string;
  summary: string;
  bodyHtml: string;
  coverAssetId: string;
  tags: string[];
  language: string;
  publishedAt: string;
  sourceUrl: string;
}

@Injectable()
export class NewsService {
  list(params: { category?: string; query?: string; cursor?: string; limit: number }): PaginatedResult<NewsItem> {
    const filtered = SAMPLE_NEWS.filter((n) => {
      const matchCategory = params.category ? n.category === params.category : true;
      const matchQuery = params.query
        ? n.title.includes(params.query) || n.summary.includes(params.query)
        : true;
      return matchCategory && matchQuery;
    });

    const sorted = [...filtered].sort((a, b) => b.publishedAt.localeCompare(a.publishedAt));
    return paginate(sorted, params.cursor, params.limit);
  }

  detail(id: string): NewsItem | undefined {
    return SAMPLE_NEWS.find((n) => n.id === id);
  }
}
