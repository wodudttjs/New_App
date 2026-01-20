import { INestApplication, ValidationPipe } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from './app.module';

describe('API E2E', () => {
  let app: INestApplication;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({ imports: [AppModule] }).compile();
    app = moduleRef.createNestApplication();
    app.useGlobalPipes(
      new ValidationPipe({
        transform: true,
        whitelist: true,
        forbidNonWhitelisted: true,
      }),
    );
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  it('/sermons list with default limit', async () => {
    const res = await request(app.getHttpServer()).get('/sermons').expect(200);
    expect(res.body.items.length).toBeGreaterThan(0);
    expect(res.body).toHaveProperty('nextCursor');
  });

  it('/sermons honors limit and cursor pagination', async () => {
    const first = await request(app.getHttpServer()).get('/sermons?limit=1').expect(200);
    expect(first.body.items).toHaveLength(1);
    expect(first.body.nextCursor).toBeTruthy();

    const next = await request(app.getHttpServer())
      .get(`/sermons?limit=1&cursor=${encodeURIComponent(first.body.nextCursor)}`)
      .expect(200);
    expect(next.body.items[0].id).not.toEqual(first.body.items[0].id);
  });

  it('/sermons detail returns 404 for missing', async () => {
    await request(app.getHttpServer()).get('/sermons/not-exist').expect(404);
  });

  it('/news list filter by category', async () => {
    const res = await request(app.getHttpServer()).get('/news?category=notice').expect(200);
    expect(res.body.items.every((item: any) => item.category === 'notice')).toBe(true);
  });

  it('/communities list filter by region prefix', async () => {
    const res = await request(app.getHttpServer()).get('/communities?region=KR-11').expect(200);
    expect(res.body.items.every((item: any) => item.regionCode.startsWith('KR-11'))).toBe(true);
  });

  it('/publications list paginates', async () => {
    const res = await request(app.getHttpServer()).get('/publications?limit=1').expect(200);
    expect(res.body.items).toHaveLength(1);
  });

  it('/home-feed returns sections', async () => {
    const res = await request(app.getHttpServer()).get('/home-feed').expect(200);
    expect(res.body).toHaveProperty('hero');
    expect(res.body).toHaveProperty('latestSermons');
    expect(res.body).toHaveProperty('latestNews');
    expect(res.body).toHaveProperty('upcomingEvents');
    expect(res.body).toHaveProperty('adSlot');
  });
});
