import { Injectable } from '@nestjs/common';
import { SAMPLE_COMMUNITIES } from '../data/sample';
import { paginate, PaginatedResult } from '../utils/paginate';

export interface Community {
  id: string;
  name: string;
  regionCode: string;
  address: string;
  lat: number;
  lng: number;
  phone: string;
  email: string;
  website: string;
  serviceTimes: { day: string; time: string }[];
  thumbnailAssetId: string;
  updatedAt: string;
}

@Injectable()
export class CommunitiesService {
  list(params: { region?: string; query?: string; cursor?: string; limit: number }): PaginatedResult<Community> {
    const filtered = SAMPLE_COMMUNITIES.filter((c) => {
      const matchRegion = params.region ? c.regionCode.startsWith(params.region) : true;
      const matchQuery = params.query ? c.name.includes(params.query) || c.address.includes(params.query) : true;
      return matchRegion && matchQuery;
    });

    const sorted = [...filtered].sort((a, b) => b.updatedAt.localeCompare(a.updatedAt));
    return paginate(sorted, params.cursor, params.limit);
  }

  detail(id: string): Community | undefined {
    return SAMPLE_COMMUNITIES.find((c) => c.id === id);
  }
}
