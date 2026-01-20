import { Injectable } from '@nestjs/common';
import { SAMPLE_SERMONS } from '../data/sample';
import { paginate, PaginatedResult } from '../utils/paginate';

export interface Sermon {
  id: string;
  slug: string;
  title: string;
  speaker: string;
  date: string;
  durationSec: number;
  summary: string;
  transcript: string;
  videoUrl: string;
  audioUrl: string;
  thumbnailAssetId: string;
  tags: string[];
  language: string;
  status: string;
  publishedAt: string;
}

@Injectable()
export class SermonsService {
  list(params: {
    query?: string;
    category?: string;
    year?: string;
    sort?: string;
    cursor?: string;
    limit: number;
  }): PaginatedResult<Sermon> {
    const filtered = SAMPLE_SERMONS.filter((s) => {
      const matchQuery = params.query
        ? s.title.includes(params.query) || s.summary.includes(params.query)
        : true;
      const matchYear = params.year ? s.date.startsWith(params.year) : true;
      const matchCategory = params.category ? s.tags.includes(params.category) : true;
      return matchQuery && matchYear && matchCategory;
    });

    const sorted = [...filtered].sort((a, b) =>
      b.publishedAt.localeCompare(a.publishedAt),
    );

    return paginate(sorted, params.cursor, params.limit);
  }

  detail(id: string): Sermon | undefined {
    return SAMPLE_SERMONS.find((s) => s.id === id);
  }
}
