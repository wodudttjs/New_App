import { IsOptional, IsString } from 'class-validator';
import { CursorPaginationDto } from '../../dto/pagination.dto';

export class SearchQueryDto extends CursorPaginationDto {
  @IsOptional()
  @IsString()
  q?: string;

  @IsOptional()
  @IsString()
  types?: string;

  @IsOptional()
  @IsString()
  language?: string;
}
