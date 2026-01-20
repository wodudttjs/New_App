import { Controller, Get, Param, Query, NotFoundException } from '@nestjs/common';
import { SermonsService } from '../services/sermons.service';
import { SermonQueryDto } from './dto/sermon-query.dto';

@Controller('sermons')
export class SermonsController {
  constructor(private readonly sermons: SermonsService) {}

  @Get()
  list(@Query() query: SermonQueryDto) {
    const result = this.sermons.list({
      query: query.query,
      category: query.category,
      year: query.year,
      sort: query.sort,
      cursor: query.cursor,
      limit: query.limit,
    });

    return { items: result.items, nextCursor: result.nextCursor };
  }

  @Get(':id')
  detail(@Param('id') id: string) {
    const item = this.sermons.detail(id);
    if (!item) {
      throw new NotFoundException('sermon not found');
    }
    const related = this.sermons
      .list({ limit: 5, cursor: undefined })
      .items.filter((s) => s.id !== id)
      .map((s) => ({ id: s.id, title: s.title }));

    return {
      ...item,
      related,
    };
  }
}
