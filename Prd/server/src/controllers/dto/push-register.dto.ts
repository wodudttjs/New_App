import { IsIn, IsOptional, IsString } from 'class-validator';

export class PushRegisterDto {
  @IsString()
  deviceId!: string;

  @IsIn(['ios', 'android'])
  platform!: 'ios' | 'android';

  @IsString()
  token!: string;

  @IsOptional()
  @IsString()
  locale?: string;
}
