import { IsIn, IsString } from 'class-validator';

export class AdsQueryDto {
  @IsString()
  @IsIn(['home', 'sermon_list', 'news_list'])
  screen!: 'home' | 'sermon_list' | 'news_list';
}
