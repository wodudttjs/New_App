import { IsOptional, IsString } from 'class-validator';
import { CursorPaginationDto } from '../../dto/pagination.dto';

export class EventsQueryDto extends CursorPaginationDto {
  @IsOptional()
  @IsString()
  from?: string;

  @IsOptional()
  @IsString()
  to?: string;

  @IsOptional()
  @IsString()
  region?: string;

  @IsOptional()
  @IsString()
  query?: string;
}
