import { Injectable } from '@nestjs/common';

export interface PushDevice {
  deviceId: string;
  platform: 'ios' | 'android';
  token: string;
  locale?: string;
}

export interface PushSubscriptions {
  deviceId: string;
  topics: Record<string, boolean>;
}

@Injectable()
export class PushService {
  private readonly devices = new Map<string, PushDevice>();
  private readonly subscriptions = new Map<string, PushSubscriptions>();

  register(device: PushDevice) {
    this.devices.set(device.deviceId, device);
    return { status: 'registered', deviceId: device.deviceId };
  }

  setSubscriptions(deviceId: string, topics: Record<string, boolean>) {
    this.subscriptions.set(deviceId, { deviceId, topics });
    return { status: 'updated', deviceId, topics };
  }

  getDevice(deviceId: string) {
    return this.devices.get(deviceId);
  }
}
