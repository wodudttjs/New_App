import { IsOptional, IsString } from 'class-validator';
import { CursorPaginationDto } from '../../dto/pagination.dto';

export class NewsQueryDto extends CursorPaginationDto {
  @IsOptional()
  @IsString()
  category?: string;

  @IsOptional()
  @IsString()
  query?: string;
}
