import { Controller, Get, Query } from '@nestjs/common';
import { AdsService } from '../services/ads.service';
import { AdsQueryDto } from './dto/ads-query.dto';

@Controller('ads')
export class AdsController {
  constructor(private readonly ads: AdsService) {}

  @Get('slots')
  list(@Query() query: AdsQueryDto) {
    return { slots: this.ads.getSlots(query.screen) };
  }
}
