import { Controller, Get, Param, Query, NotFoundException } from '@nestjs/common';
import { NewsService } from '../services/news.service';
import { NewsQueryDto } from './dto/news-query.dto';

@Controller('news')
export class NewsController {
  constructor(private readonly news: NewsService) {}

  @Get()
  list(@Query() query: NewsQueryDto) {
    const result = this.news.list({
      category: query.category,
      query: query.query,
      cursor: query.cursor,
      limit: query.limit,
    });
    return { items: result.items, nextCursor: result.nextCursor };
  }

  @Get(':id')
  detail(@Param('id') id: string) {
    const item = this.news.detail(id);
    if (!item) {
      throw new NotFoundException('news not found');
    }
    return item;
  }
}
