import { Body, Controller, Post, BadRequestException } from '@nestjs/common';
import { PushService } from '../services/push.service';
import { PushRegisterDto } from './dto/push-register.dto';
import { PushSubscriptionsDto } from './dto/push-subscriptions.dto';

@Controller('push')
export class PushController {
  constructor(private readonly push: PushService) {}

  @Post('register')
  register(@Body() body: PushRegisterDto) {
    return this.push.register({
      deviceId: body.deviceId,
      platform: body.platform,
      token: body.token,
      locale: body.locale,
    });
  }

  @Post('subscriptions')
  subscriptions(@Body() body: PushSubscriptionsDto) {
    const device = this.push.getDevice(body.deviceId);
    if (!device) {
      throw new BadRequestException('device not registered');
    }
    return this.push.setSubscriptions(body.deviceId, body.topics);
  }
}
