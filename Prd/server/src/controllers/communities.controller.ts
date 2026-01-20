import { Controller, Get, Param, Query, NotFoundException } from '@nestjs/common';
import { CommunitiesService } from '../services/communities.service';
import { CommunityQueryDto } from './dto/community-query.dto';

@Controller('communities')
export class CommunitiesController {
  constructor(private readonly communities: CommunitiesService) {}

  @Get()
  list(@Query() query: CommunityQueryDto) {
    const result = this.communities.list({
      region: query.region,
      query: query.query,
      cursor: query.cursor,
      limit: query.limit,
    });
    return { items: result.items, nextCursor: result.nextCursor };
  }

  @Get(':id')
  detail(@Param('id') id: string) {
    const item = this.communities.detail(id);
    if (!item) {
      throw new NotFoundException('community not found');
    }
    return item;
  }
}
