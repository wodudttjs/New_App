# 배포 다이어그램/환경 (Dev/Staging/Prod)

## 환경
- Dev: 개발자 로컬 + 개발용 스토리지 + 테스트 푸시
- Staging: 운영과 동일한 인프라, 테스트 데이터
- Prod: 실제 운영 데이터

## 구성
- API: NestJS (컨테이너)
- DB: Postgres
- Cache: Redis
- CMS: Directus
- Search: Meilisearch
- Object Storage + CDN
- Push: FCM/APNs

## CI/CD (요약)
- Pull Request: lint/test/build
- main 브랜치: build -> container push -> deploy (staging)
- tag/release: deploy (prod)

## 로깅/모니터링
- API: request 로그 + 에러 알림
- 앱: Crashlytics
- Push: 전송/오픈 로그
