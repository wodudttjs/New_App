# 아키텍처 요약 (MVP 기준)

## 구성도
- Mobile App (iOS/Android)
  - UI/State/Cache
  - Video/PDF Player
  - Push Receiver
  - Analytics SDK
- API Gateway / Backend
  - REST API
  - Home feed 집계
  - Push/Subscriptions
  - Search
- Headless CMS
- Search Engine (Meilisearch)
- Notification Service (FCM/APNs)
- Object Storage + CDN
- Transcoding/Processing

## 백엔드(현재 리포지토리) 구성
- NestJS 기반 REST API
- 인메모리 샘플 데이터
- Cursor 기반 페이징

## 엔드포인트 (요약)
- GET /home-feed
- GET /sermons, GET /sermons/:id
- GET /news, GET /news/:id
- GET /communities, GET /communities/:id
- GET /publications, GET /publications/:id
- GET /events, GET /events/:id
- GET /search
- POST /push/register, POST /push/subscriptions
- GET /ads/slots

## 광고 정책
- 상세 화면에서는 광고 슬롯 없음
- 홈/목록 하단 1 슬롯만 제공
