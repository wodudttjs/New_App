# FFWPU App Stack (MVP defaults)

This repo starts the MVP stack using defaults:
- Mobile: React Native (TypeScript) — scaffolding next.
- Backend: NestJS (TypeScript) stub APIs aligning to task1–4.
- CMS: Strapi (to be provisioned) with PostgreSQL.
- Search: Meilisearch (lightweight for MVP).

## Backend (NestJS)
Location: `server/`
- Stub endpoints: `/home-feed`, `/sermons`, `/news`, `/communities`, `/publications`.
- To run locally:
  1) Install deps: `cd server && npm install`
  2) Dev: `npm run start:dev`
  3) Build: `npm run build && npm start`

## Next steps
1) Scaffold mobile app (React Native/Expo) with screens matching PRD: Home, SermonList/Detail, NewsList/Detail, CommunitySearch/Detail, PublicationsList/PDFViewer, Settings.
2) Stand up Strapi + PostgreSQL + Meilisearch via docker-compose for CMS/search.
3) Wire backend controllers to Strapi data via REST/GraphQL; add caching and cursor pagination.
4) Add analytics/push integrations (Firebase) and ad-slot contract on home/list only.
5) Harden for prod: env configs, logging, error handling, validation, security headers, rate limits.
