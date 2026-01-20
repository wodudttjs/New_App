import { Injectable } from '@nestjs/common';
import { SAMPLE_PUBLICATIONS } from '../data/sample';
import { paginate, PaginatedResult } from '../utils/paginate';

export interface Publication {
  id: string;
  title: string;
  issue: string;
  publishedAt: string;
  coverAssetId: string;
  pdfAssetId: string;
  language: string;
  tags: string[];
  rightsNote: string;
  pdfUrl: string;
}

@Injectable()
export class PublicationsService {
  list(params: { cursor?: string; limit: number }): PaginatedResult<Publication> {
    const sorted = [...SAMPLE_PUBLICATIONS].sort((a, b) => b.publishedAt.localeCompare(a.publishedAt));
    return paginate(sorted, params.cursor, params.limit);
  }

  detail(id: string): Publication | undefined {
    return SAMPLE_PUBLICATIONS.find((p) => p.id === id);
  }
}
