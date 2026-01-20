import { IsIn, IsOptional, IsString } from 'class-validator';
import { CursorPaginationDto } from '../../dto/pagination.dto';

const SORT_OPTIONS = ['recent'] as const;

export class SermonQueryDto extends CursorPaginationDto {
  @IsOptional()
  @IsString()
  query?: string;

  @IsOptional()
  @IsString()
  category?: string;

  @IsOptional()
  @IsString()
  year?: string;

  @IsOptional()
  @IsIn(SORT_OPTIONS as readonly string[])
  sort: (typeof SORT_OPTIONS)[number] = 'recent';
}
