# FFWPU App Stack (MVP defaults)

This repo starts the MVP stack using defaults:
- Mobile: Flutter — 기본 화면/라우팅 스캐폴드 포함.
- Backend: NestJS (TypeScript) stub APIs aligning to task1–4.
- CMS: Directus (Docker) with PostgreSQL.
- Search: Meilisearch (Docker).

## Backend (NestJS)
Location: `server/`
- Stub endpoints: `/home-feed`, `/sermons`, `/news`, `/communities`, `/publications`.
- To run locally:
  1) Install deps: `cd server && npm install`
  2) Dev: `npm run start:dev`
  3) Build: `npm run build && npm start`

## Mobile (Flutter)
Location: `mobile/`
- Basic navigation and placeholder screens: Home, Sermons, News, Communities, Publications, Settings.
- API client scaffold with `dio`.

## Infra (Docker)
Location: `infra/`
- `docker-compose.yml` includes Postgres, Redis, Meilisearch, Directus.
- Copy `.env.example` to `.env` and set secrets before running.

## Next steps
1) Wire Flutter screens to API data and add state management.
2) Connect NestJS to Directus + Postgres and add caching (Redis).
3) Implement search indexing + push delivery integration.
4) Add analytics and ad-slot policy enforcement.
5) Harden for prod: env configs, logging, security headers, rate limits.
