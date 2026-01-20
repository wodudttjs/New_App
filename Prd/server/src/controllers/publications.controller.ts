import { Controller, Get, Param, Query, NotFoundException } from '@nestjs/common';
import { PublicationsService } from '../services/publications.service';
import { CursorPaginationDto } from '../dto/pagination.dto';

@Controller('publications')
export class PublicationsController {
  constructor(private readonly publications: PublicationsService) {}

  @Get()
  list(@Query() query: CursorPaginationDto) {
    const result = this.publications.list({ cursor: query.cursor, limit: query.limit });
    return { items: result.items, nextCursor: result.nextCursor };
  }

  @Get(':id')
  detail(@Param('id') id: string) {
    const item = this.publications.detail(id);
    if (!item) {
      throw new NotFoundException('publication not found');
    }
    return item;
  }
}
