import { Controller, Get, Query } from '@nestjs/common';
import { SearchService } from '../services/search.service';
import { SearchQueryDto } from './dto/search-query.dto';

@Controller('search')
export class SearchController {
  constructor(private readonly search: SearchService) {}

  @Get()
  searchAll(@Query() query: SearchQueryDto) {
    const types = query.types
      ? query.types.split(',').map((value) => value.trim()).filter(Boolean)
      : undefined;

    const result = this.search.search({
      q: query.q,
      types: types as any,
      language: query.language,
      cursor: query.cursor,
      limit: query.limit,
    });

    return { items: result.items, nextCursor: result.nextCursor };
  }
}
