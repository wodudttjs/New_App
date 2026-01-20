1) 전체 구성 한 장 요약
[Mobile App iOS/Android]
  - UI/State/Cache
  - Video/PDF Player
  - Push Receiver
  - Analytics SDK
        |
        | HTTPS (JWT optional)
        v
[API Gateway / Backend]
  - REST/GraphQL API
  - Auth(optional)
  - Content aggregation (home-feed)
  - Bookmark/ContinueWatching(V1)
  - Admin hooks (publish -> push)
        |
   -----------------------------
   |            |              |
   v            v              v
[Headless CMS] [Search Engine] [Notification Service]
(Content DB)   (Meilisearch/   (FCM/APNs via provider)
               OpenSearch)
   |
   v
[Object Storage + CDN]
(Images/Videos/PDF)
   |
   v
[Transcoding/Processing]
(thumbnails, HLS, PDF optimize)

2) 클라이언트(모바일 앱) 아키텍처
2.1 앱 내부 레이어링

권장 구조(클린 아키텍처 느낌으로 단순화)

Presentation(UI)

화면(Home, Sermons, News, Communities, Media, Settings)

공통 컴포넌트(ContentCard, ErrorState, Skeleton 등)

Domain(유스케이스)

GetHomeFeed, SearchSermons, GetSermonDetail, GetCommunities…

Data(리포지토리)

API Client, Local Cache DB, Media Cache, Analytics wrapper

2.2 로컬 저장(핵심)

캐시/오프라인: SQLite(또는 Room/Realm)로 목록/상세 일부 캐시

이어보기(Continue Watching): contentId + positionSec + updatedAt 로컬 저장(MVP)

북마크(MVP는 로컬, V1부터 계정 연동 서버 동기화)

2.3 미디어 재생(UX 핵심)

설교 영상: HLS 스트리밍(CDN) + 플레이어(ExoPlayer/AVPlayer)

묵상 모드: 재생 중 알림 최소, 화면 구성 단순화 옵션

PDF: 앱 내 PDF 뷰어(줌/페이지), 대용량은 “Wi-Fi 권장”

2.4 딥링크/공유

딥링크: app://sermon/{id}, app://news/{id}, app://event/{id}

공유는 “웹 링크 + 앱 딥링크 fallback” 구조로 SEO/유입도 챙김

3) 백엔드(API) 아키텍처
3.1 API 서버 역할

콘텐츠 목록/상세 제공(서버는 “진실의 원천”)

홈 피드 집계(home-feed): Sermon/News/Event/Community 프리뷰를 한 번에 내려줌

(V1) 계정/북마크/이어보기/알림 구독 저장

운영 이벤트 훅: “발행(Publish) → 푸시 발송/검색 인덱싱/캐시 무효화”

3.2 API 형태 선택

MVP 추천: REST

화면 중심 엔드포인트 설계가 빠르고 단순

예: /home-feed, /sermons, /sermons/{id}, /news, /communities

V1부터 GraphQL을 도입해도 되는데, 초반은 REST가 유지보수 쉬움

3.3 캐시/성능

CDN 캐시: 이미지/썸네일/PDF/영상은 CDN에서 처리

API 캐시: 홈 피드/목록 응답은 짧게(예: 5~10분) 캐시

무효화: CMS에서 콘텐츠 발행 시 캐시 purge

4) CMS(콘텐츠 운영) 아키텍처
4.1 왜 CMS가 핵심인가

이 앱은 “기능 앱”이라기보다 콘텐츠 앱이야.
운영자가 설교/소식/행사/출판물을 올리고, 검수하고, 푸시 보내고, 번역 붙이는 흐름이 제품 품질을 좌우함.

4.2 CMS 워크플로우(권장)

Draft → Review → Published → Archived

발행 시 자동 트리거:

검색 인덱싱

홈 피드 캐시 무효화

“푸시 발송(옵션)” 큐에 등록

4.3 다국어(확장 대비)

content_localizations 방식 추천

원문 콘텐츠 ID에 번역본을 연결

앱은 locale에 따라 적절한 버전 선택

5) 미디어/문서 저장소 + CDN
5.1 저장

Object Storage(S3 계열): 이미지/썸네일/영상/HLS 세그먼트/PDF

메타데이터는 DB/CMS에 저장, 실제 파일은 스토리지에 저장

5.2 CDN

전 세계 스트리밍 품질 확보

썸네일 리사이즈/웹P 변환 같은 이미지 최적화도 CDN 레벨에서 가능

5.3 트랜스코딩/처리 파이프라인

업로드 → 백그라운드 작업

영상: HLS 변환, 여러 화질(Adaptive bitrate)

썸네일 생성

PDF: 최적화/용량 줄이기/표지 이미지 추출

이 파이프라인은 “운영이 업로드만 해도 앱에서 바로 보기 좋게” 만드는 핵심.

6) 검색(Search) 아키텍처
6.1 왜 별도 검색이 필요한가

설교/연설/뉴스가 쌓이면 DB LIKE 검색은 한계가 빨리 옴.

6.2 구성

Search Engine: Meilisearch(가벼움) 또는 OpenSearch(확장성)

인덱스:

sermons(title, speaker, tags, transcript 일부)

news(title, tags, summary)

publications(title, issue)

communities(name, region, address)

6.3 인덱싱 트리거

CMS “Published” 시 Search index 업데이트

삭제/비공개 시 인덱스 제거

7) 푸시(알림) 아키텍처
7.1 원칙

기본 OFF, 사용자 동의 기반

카테고리 토픽: sermon, notice, event_reminder

7.2 흐름
[CMS publish] -> (hook) -> [Backend]
    -> [Notification Queue] -> [Push Provider(FCM/APNs)]
    -> [App Deep Link Open]

7.3 스케줄 알림(행사 리마인더)

이벤트 시작 24h/1h 전 같은 예약 푸시는

백엔드 스케줄러(크론/큐)로 처리

사용자가 관심 행사로 저장한 대상에게만 발송

8) 분석(Analytics) + 광고(Ads)
8.1 분석

앱 이벤트(시청 시작/25-50-75-완료, 커뮤니티 길찾기 클릭 등) 수집

운영 대시보드: “어떤 설교/소식이 실제로 소비되는지”를 확인

8.2 광고(영성 UX 보호)

목록/홈 하단 1 슬롯만 네이티브 광고

설교/뉴스 “본문”에는 광고 금지(아키텍처로 강제)

예: 서버에서 ad_slots를 “list/home only”로만 내려주고

상세 API는 광고 필드를 아예 지원하지 않는 식으로 구조적으로 차단

9) 보안/권한/컴플라이언스 포인트

인증(MVP는 비로그인 가능)

V1부터 로그인 도입 시 JWT + Refresh 토큰

저작권/권리

출판물 PDF, 설교 텍스트/이미지 사용권 검증 프로세스는 CMS에 체크박스/증빙 필드로 강제

개인정보 최소수집

계정 없이도 이용 가능하게 설계(분석 옵트아웃 제공)

10) MVP에서 현실적인 “최소 기술 스택” 추천

모바일: Flutter / React Native / Native 중 택1

미디어/플레이어 안정성이 중요해서, RN/Flutter 선택 시 플레이어 플러그인 검증 필수

백엔드: Node.js(NestJS) 또는 FastAPI

CMS: Strapi / Directus / Sanity 같은 Headless CMS

스토리지/CDN: S3 호환 + CloudFront 급 CDN

검색: Meilisearch(빠른 도입) → 성장하면 OpenSearch

푸시: FCM + APNs

분석: Firebase Analytics(초기) → 필요시 Amplitude

11) “대표 사용자 플로우”에서 아키텍처가 어떻게 동작하는지
A) 홈 진입

앱 → /home-feed 호출

API는 캐시된 집계 응답 반환(설교/뉴스/행사/커뮤니티 일부)

이미지는 CDN에서 로드

B) 설교 재생

상세 API로 메타/텍스트 받음

영상은 CDN(HLS)에서 스트리밍

재생 위치는 로컬 저장(→ V1부터 서버 동기화 가능)

C) 커뮤니티 찾기

지역 선택/검색 → /communities?region=

상세에서 “길찾기” 누르면 OS 지도 딥링크

D) 운영자가 설교 발행

CMS에서 Published

웹훅 → 백엔드

검색 인덱싱 + 홈 캐시 무효화 + (옵션) 푸시 큐 등록