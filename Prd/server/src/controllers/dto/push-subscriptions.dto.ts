import { IsObject, IsString } from 'class-validator';

export class PushSubscriptionsDto {
  @IsString()
  deviceId!: string;

  @IsObject()
  topics!: Record<string, boolean>;
}
