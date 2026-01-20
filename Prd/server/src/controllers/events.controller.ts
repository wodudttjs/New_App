import { Controller, Get, NotFoundException, Param, Query } from '@nestjs/common';
import { EventsService } from '../services/events.service';
import { EventsQueryDto } from './dto/events-query.dto';

@Controller('events')
export class EventsController {
  constructor(private readonly events: EventsService) {}

  @Get()
  list(@Query() query: EventsQueryDto) {
    const result = this.events.list({
      from: query.from,
      to: query.to,
      region: query.region,
      query: query.query,
      cursor: query.cursor,
      limit: query.limit,
    });
    return { items: result.items, nextCursor: result.nextCursor };
  }

  @Get(':id')
  detail(@Param('id') id: string) {
    const item = this.events.detail(id);
    if (!item) {
      throw new NotFoundException('event not found');
    }
    return item;
  }
}
