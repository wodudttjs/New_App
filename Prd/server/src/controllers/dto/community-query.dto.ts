import { IsOptional, IsString } from 'class-validator';
import { CursorPaginationDto } from '../../dto/pagination.dto';

export class CommunityQueryDto extends CursorPaginationDto {
  @IsOptional()
  @IsString()
  region?: string;

  @IsOptional()
  @IsString()
  query?: string;
}
