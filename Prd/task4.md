좋아. 지금부터 (1) 우선순위(MoSCoW)+MVP 스프린트 백로그, (2) 화면별 컴포넌트/상태/에러 케이스, (3) DB/콘텐츠 스키마, (4) 푸시·분석 이벤트 트래킹 플랜을 Task 단위로 아주 잘게 쪼개서 정리할게.
(형식: Epic → Feature → User Story → Tasks(개발/디자인/QA/운영) → Done(수용 기준))

1) MoSCoW + MVP 스프린트 백로그 (Task 분해)
1.0 MoSCoW 우선순위 정의 (전체 기능)
Must (MVP 필수)

홈 피드(최신 설교/소식/행사 미리보기 + 커뮤니티 찾기 바로가기)

말씀/설교: 목록/검색/필터/상세(영상 재생 + 텍스트) + 이어보기(로컬)

소식(뉴스/블로그): 목록/상세

커뮤니티/교회 찾기: 지역 검색 + 리스트 + 상세 + 길찾기/연락 액션

미디어: 영상/출판물(PDF 뷰) 최소

설정: 알림 구독(기본 OFF), 개인정보/약관, 앱 정보

수익: 피드 하단 1 슬롯 네이티브 광고(콘텐츠 본문 광고 금지)

Should (MVP 다음, V1)

로그인/동기화(북마크/이어보기/설정)

행사 캘린더(월간+리스트) + 리마인더

즐겨찾기(북마크) + 히스토리(최근 본 콘텐츠)

오프라인 저장(오디오/텍스트)

다국어(한/영)

Could (V2)

묵상 노트 / 기도 리스트

게시판(간증/질문) + 신고/중재

정기후원, 인앱 결제 완결(권한/정책/법무 확보 전)

Won’t (이번 범위 제외)

실시간 채팅/DM

외부 커머스 연동

고급 추천(AI 추천) (초기에는 규칙 기반만)

1.1 MVP “스프린트 0” (프로젝트 기반 작업)

개발 착수 전에 실패 확률을 낮추는 셋업 스프린트

Epic S0: 제품/기술 기반

User Story S0-1: 앱 기본 뼈대가 있어야 한다

Tasks (Dev)

 모바일 프로젝트 생성(iOS/Android) + 라우팅/네비게이션 프레임 구축

 전역 상태관리(토큰/설정/캐시) 선택 및 세팅

 환경 분리(dev/stage/prod) + 빌드 파이프라인 기본

 로깅/크래시 리포팅(Firebase Crashlytics 등) 붙이기

Tasks (Design)

 디자인 시스템 초안(색/타이포/버튼/카드/리스트/아이콘 규칙)

 “차분한 종교 톤” UI 가이드(여백, 대비, 모션 최소)

Tasks (QA)

 기본 탐색(탭/스택) QA 체크리스트 작성

Done

앱 실행 → 탭 이동/뒤로가기/딥링크(기본) 동작

크래시 리포팅 이벤트 1건 수집 확인

User Story S0-2: 콘텐츠를 가져오는 API/CMS가 있어야 한다

Tasks (Dev/BE)

 CMS(Headless) 혹은 Custom API 스택 결정

 콘텐츠 타입 최소 3종(Sermon, News, Community) CRUD API 스캐폴딩

 페이징/정렬/검색(키워드) 기본 파라미터 정의

 이미지/동영상 URL 규격 정의(thumb, cover, original)

Tasks (Ops)

 관리자 계정/권한(Owner/Editor/Viewer) 생성 정책

Done

샘플 데이터 30개 이상으로 앱에서 목록 렌더 가능

1.2 MVP “스프린트 1” (핵심 콘텐츠 읽기: 말씀/소식)
Epic E1: 말씀/설교(최우선)

US E1-1: 사용자는 최신 설교를 리스트로 보고 선택할 수 있다

Tasks (Design)

 말씀 목록 와이어프레임(카드/리스트) + 필터 UI

 “묵상 모드” UX(알림 최소, 화면 단순)

Tasks (FE)

 SermonList 화면 구현

 필터(카테고리/연도) UI + API 파라미터 연결

 검색(제목/설명) 입력창 + 디바운스

 무한스크롤/페이징

Tasks (BE)

 GET /sermons?query=&category=&year=&sort=recent&cursor=

Tasks (QA)

 목록 로딩/빈 상태/오류 상태 테스트케이스

Done

네트워크 정상/불안정/오프라인 각각에서 UI가 깨지지 않음

필터/검색 결과가 일관됨

US E1-2: 사용자는 설교 상세에서 영상을 재생하고 텍스트를 읽을 수 있다

Tasks (Design)

 설교 상세 레이아웃(상단 플레이어 + 하단 텍스트/요약)

 공유/북마크/이어보기 아이콘 위치 결정

Tasks (FE)

 SermonDetail 화면 구현

 영상 플레이어(기본 재생/일시정지/시킹/전체화면)

 텍스트 영역(확대/축소, 줄간격 옵션)

 “이어보기” 로컬 저장(콘텐츠ID+타임코드)

Tasks (BE)

 GET /sermons/{id} (video_url, transcript, summary 포함)

Tasks (QA)

 재생 중 백그라운드 전환, 화면 회전, 앱 재시작 후 이어보기 확인

Done

3가지 네트워크 품질에서 재생 안정

마지막 재생 위치 저장/복원 성공률 99%+

Epic E2: 소식(뉴스/블로그)

US E2-1: 사용자는 소식 목록/상세를 읽을 수 있다

Tasks (Design)

 뉴스 카드 컴포넌트(썸네일/제목/날짜/요약)

 본문 가독성 규칙(폰트, 폭, 이미지 캡션)

Tasks (FE)

 NewsList 화면 구현 + 카테고리(공지/칼럼) 탭

 NewsDetail(본문 렌더, 이미지 갤러리)

 공유(딥링크) 버튼

Tasks (BE)

 GET /news?category=&query=&cursor=

 GET /news/{id}

Tasks (QA)

 본문 내 링크/이미지 깨짐 처리, HTML sanitize 확인

Done

상세 본문에서 “외부 광고 삽입” 없음

링크는 안전하게 열리고(외부 브라우저/웹뷰 정책) 크래시 없음

1.3 MVP “스프린트 2” (커뮤니티+홈+미디어 최소)
Epic E3: 커뮤니티/교회 찾기

US E3-1: 사용자는 지역 검색으로 커뮤니티를 찾는다

Tasks (Design)

 커뮤니티 검색 UX(지역 드롭다운/검색바) + 리스트

 상세 화면(주소/전화/예배시간/길찾기)

Tasks (FE)

 CommunitySearch 화면 구현

 지역 필터(국가/도시/주/도 등) 컴포넌트

 CommunityDetail 화면 구현

 길찾기 딥링크(기본 지도 앱), 전화/메일 액션

Tasks (BE)

 GET /communities?region=&query=&cursor=

 GET /communities/{id}

Tasks (QA)

 위치 권한 거부/허용 분기 테스트(권한 없이도 검색 가능)

Done

연락/길찾기 액션이 OS 정책에 맞게 동작

Epic E4: 홈(허브)

US E4-1: 홈에서 최신/추천 콘텐츠를 빠르게 본다

Tasks (Design)

 홈 섹션 구성(최신 설교, 최신 소식, 다가오는 행사, 커뮤니티 찾기)

 광고 슬롯 위치(피드 최하단) 고정 규칙

Tasks (FE)

 Home 화면 구현(섹션별 프리뷰 + 더보기 이동)

 “조용한 모드” 토글(영상 재생 중 홈 배너 최소)

Tasks (BE)

 GET /home-feed (sermons/news/events/community-shortcuts)

Tasks (QA)

 홈 새로고침, 캐시, 느린 네트워크, 빈 섹션 처리

Done

홈 진입 2초 내 1차 렌더(스켈레톤 포함)

Epic E5: 미디어(최소)

US E5-1: 사용자는 출판물(PDF)을 열람한다

Tasks (Design)

 Publications 리스트 UI + 뷰어 진입 UX

Tasks (FE)

 PublicationsList 구현

 PDF 뷰어(페이지 스와이프/줌)

Tasks (BE)

 GET /publications (title, cover, pdf_url)

Tasks (QA)

 대용량 PDF 로딩/오류 처리, Wi-Fi 권장 메시지

Done

PDF 열람이 앱 크래시 없이 안정적으로 동작

1.4 MVP “스프린트 3” (설정/알림/광고/정책)
Epic E6: 설정/약관/알림 구독

US E6-1: 사용자는 알림 구독을 켜고 끌 수 있다

Tasks (Design)

 설정 화면(토글 리스트) + 설명 문구

Tasks (FE)

 Settings 화면 구현

 푸시 권한 요청 플로우(설정에서만 요청)

 구독 토글(신규 설교/공지/행사 리마인더)

Tasks (BE)

 device token 등록/해제 API

 topic 구독 상태 저장

Tasks (QA)

 iOS/Android 권한 거부 후 재요청 안내, 토큰 갱신 처리

Done

사용자가 원치 않으면 기본적으로 어떤 푸시도 안 옴(기본 OFF)

Epic E7: 광고(피드 1슬롯)

US E7-1: 광고가 묵상 경험을 방해하지 않는다

Tasks (Design)

 네이티브 광고 카드 디자인(콘텐츠 카드와 구분 “AD” 라벨)

Tasks (FE)

 홈/목록 하단 광고 슬롯 구현

 본문(설교/뉴스 상세) 광고 차단 보장

Tasks (QA)

 광고 노출/미노출/로딩 실패 시 레이아웃 깨짐 방지

Done

상세 본문 광고 0건, 목록 하단에만 노출

2) 화면 목록 + 각 화면별 컴포넌트/상태/에러케이스 (Task 분해)

아래는 “화면 설계 작업”을 Task로 쪼갠 것이야. (각 화면마다 동일한 형식)

공통 컴포넌트 Task (전 화면 공통)

 AppHeader(타이틀/검색/공유/뒤로)

 ContentCard(썸네일/제목/메타)

 SkeletonLoader(로딩 스켈레톤)

 EmptyState(빈 화면: 안내문구+바로가기)

 ErrorState(재시도 버튼 + 에러 코드)

 OfflineBanner(오프라인 표시)

 BottomSheet(필터/액션)

 Toast/Snackbar(저장됨/실패)

 WebViewWrapper(외부 링크/기부 페이지)

2.1 Home
컴포넌트

HeroBanner(오늘의 문구/슬로건)

Section: LatestSermons(가로 스크롤 카드)

Section: LatestNews(세로 3개)

Section: UpcomingEvents(리스트)

CTA: FindCommunity

AdSlot(최하단)

상태(State)

Loading: 섹션별 스켈레톤

Partial: 일부 섹션만 로드(나머지 placeholder)

Empty: 전체/특정 섹션 데이터 0개

Error: /home-feed 실패(재시도)

에러 케이스

홈 피드 API 타임아웃 → 캐시 데이터 fallback

이미지 로딩 실패 → 기본 placeholder

광고 로딩 실패 → 빈 공간 없이 collapse

화면 Task

 와이어프레임 작성

 UI 시안(차분톤/여백)

 섹션별 데이터 계약(API 응답 스키마) 확정

 캐시 정책(홈 10분 캐시) 정의

 QA: 느린 네트워크/오프라인

2.2 SermonList
컴포넌트

SearchBar(디바운스)

FilterChips(카테고리/연도)

SermonCard(썸네일, 제목, 날짜, 길이)

InfiniteList

상태

Loading(첫 로드)

Refreshing(풀투리프레시)

Empty(검색 결과 없음)

Error(재시도)

에러 케이스

필터 조합이 잘못된 값 → 400 처리 UI(“필터를 초기화하세요”)

페이징 중 다음 페이지 실패 → “더 불러오기 실패” 토스트 + 재시도 버튼

Task

 필터 설계(카테고리 taxonomy 확정)

 검색 UX(최근 검색어 저장 여부 결정)

 접근성(키보드/포커스 이동)

2.3 SermonDetail
컴포넌트

VideoPlayer(기본/전체화면)

MetaBlock(제목/설교자/날짜)

Actions(북마크/공유/텍스트크기)

Tabs(요약/전문/관련)

ContinueWatching(이어보기 안내)

상태

VideoBuffering / PlaybackError

TranscriptLoading / TranscriptEmpty

SaveState(북마크 성공/실패)

에러 케이스

영상 URL 만료/403 → “재생 불가” + 대체 링크(웹 열기)

자막/전문 미제공 → “원문이 제공되지 않습니다” 안내

이어보기 데이터 손상 → 초기화 후 재생

Task

 플레이어 라이브러리 선정

 이어보기 저장 규격(콘텐츠ID, 초단위, 업데이트 시간)

 “묵상 모드” 옵션(화면 잠금 방지/알림 최소)

2.4 NewsList / NewsDetail
컴포넌트

CategoryTabs(공지/소식/칼럼)

NewsCard

ArticleRenderer(HTML/Markdown)

ImageGallery

상태

Loading/Empty/Error

링크 클릭 시 WebView/OpenExternal 선택

에러 케이스

본문 HTML 깨짐 → sanitize 후 fallback(텍스트만)

외부 링크 위험 URL → 경고 후 열기

Task

 본문 렌더 정책(HTML 허용 태그/스타일 제한)

 공유 딥링크 규격 정의

2.5 CommunitySearch / CommunityDetail
컴포넌트

RegionPicker(국가/도/시)

SearchInput(키워드)

CommunityRow(이름/주소 요약/거리 optional)

Detail: MapPreview(스냅샷) + Actions(길찾기/전화/메일)

상태

LocationPermission(허용/거부/미결정)

NoResults

Error(서버/네트워크)

에러 케이스

전화 앱 없음/권한 문제 → 안내

지도 앱 딥링크 실패 → 주소 복사 기능 제공

지역 데이터 누락 → “운영자에게 문의” 링크

Task

 지역 데이터 표준화(국가코드/행정구역)

 지도 연동 정책(기본 앱 우선)

2.6 PublicationsList / PDFViewer
컴포넌트

PublicationCard(표지/제목/발행일)

PDFViewer(줌/페이지)

DownloadButton(V1)

상태

Loading/Empty/Error

LargeFileWarning

에러

PDF 손상/404 → “열 수 없음” + 신고

Task

 파일 크기/형식 제한

 저작권/배포권 표기 영역

2.7 Settings
컴포넌트

NotificationToggles

QuietHours(조용한 시간)

LegalLinks(약관/개인정보)

AppInfo(버전)

에러

푸시 권한 거부 → OS 설정으로 이동 안내

Task

 권한 요청을 “사용자 액션 후”에만 하도록 강제

 정책 문구 템플릿 작성

3) DB/콘텐츠 스키마 (Task 분해)
3.0 데이터 모델링 원칙(선정 Task)

 콘텐츠 타입 정의(최소 6종): Sermon, Speech, News, Event, Community, Publication

 공통 필드 표준화: id, slug, title, summary, body, language, tags, status, createdAt, updatedAt, publishedAt

 미디어 에셋 테이블 분리(이미지/영상/PDF)

 다국어는 “content_localizations”로 분리(번역본 연결)

3.1 테이블/컬렉션 설계 Tasks
A) users (V1)

 users: id, email, displayName, role, regionPreference, languagePreference, createdAt

 user_bookmarks: userId, contentType, contentId, createdAt

 user_continue_watching: userId?, contentId, positionSec, updatedAt (MVP는 로컬, V1은 서버)

B) sermons

 sermons: id, slug, title, speaker, date, durationSec, summary, transcript, videoAssetId, audioAssetId, thumbnailAssetId, tags[], language, status, publishedAt

 sermon_series(optional): id, title, description

 sermon_series_map: sermonId, seriesId, order

C) speeches (아카이브)

 speeches: id, title, speaker, date, body, sourceUrl, tags[], language, publishedAt

 speech_collections: id, name (예: Mother’s Speeches 같은 컬렉션), description

 speech_collection_map: speechId, collectionId, order

D) news

 news: id, category(enum: notice/news/column), title, summary, bodyHtml/bodyMd, coverAssetId, tags[], language, publishedAt, sourceUrl

E) events

 events: id, title, description, startAt, endAt, timezone, locationName, address, lat, lng, registrationUrl, contactInfo, tags[], language, publishedAt

 event_regions: eventId, regionCode (필터링)

F) communities

 communities: id, name, regionCode, address, lat, lng, phone, email, website, serviceTimes(json), description, thumbnailAssetId, updatedAt

G) publications

 publications: id, title, issue, publishedAt, coverAssetId, pdfAssetId, language, tags[], rightsNote

H) assets

 assets: id, type(image/video/audio/pdf), url, mimeType, sizeBytes, width, height, durationSec, checksum, createdAt

I) moderation/feedback (V1)

 reports: id, userId?, contentType, contentId, reason, message, createdAt, status

 corrections: id, contentType, contentId, proposedText, createdAt, status

3.2 API 계약(스키마 기반) Tasks

 REST/GraphQL 선택

 목록 API 공통: cursor 기반 페이징, sort, filter, query

 상세 API: 관련 콘텐츠(related ids) 포함 여부 결정

 검색 API: 타입별/통합 검색

 권한: 관리자만 POST/PUT, 앱은 GET 중심

3.3 데이터 마이그레이션/시딩 Tasks

 초기 시딩: 설교 30, 뉴스 30, 커뮤니티 100, 출판물 10 (샘플)

 임포트 툴: CSV/JSON 업로드 → CMS 반영

 중복 제거 규칙(slug/제목+날짜)

3.4 운영 워크플로우 Tasks

 status(draft/review/published/archived) 정의

 발행 승인(Reviewer) 단계 강제

 발행 시 푸시 옵션(checkbox)

 정정 로그(누가/언제/무엇을) 저장

4) 푸시 & 분석 이벤트 트래킹 플랜 (Task 분해)
4.0 목표

“영성 UX”를 해치지 않으면서도, **콘텐츠 소비/재방문/전환(커뮤니티 연결, 기부 이동)**을 측정하고 개선

4.1 푸시 설계 Tasks
A) 푸시 카테고리 정의

 신규 설교 알림

 공지/중요 소식 알림

 행사 리마인더(24h/1h 전)

 (V2) 일일 말씀 알림

B) 구독/권한 정책

 기본값: 전부 OFF

 설정 화면에서만 권한 요청

 조용한 시간(예: 22:00~07:00) 설정

 국가/시간대 기반 스케줄링

C) 디바이스 토큰/토픽

 device_register: userId? + deviceId + token + platform + locale

 topic_subscribe: (sermon, notice, event_reminder)

 토큰 갱신 핸들링(iOS APNs/Android FCM)

D) 푸시 메시지 템플릿

 제목/본문 길이 가이드(짧고 정중)

 딥링크 규격(app://sermon/{id}, app://news/{id}, app://event/{id})

 실패 시 폴백(홈으로)

E) 푸시 발송 운영

 CMS 발행 시 “푸시 발송” 옵션

 긴급 공지 전용 채널(최소 사용)

 발송 로그 저장(누가/언제/타겟/성공률)

Done(수용 기준)

토글 ON 사용자에게만 푸시 도달

클릭 시 해당 상세 화면으로 정확히 이동(딥링크 성공)

4.2 분석 이벤트(Analytics) Tasks
A) 이벤트 네이밍 규칙

 snake_case 통일

 공통 속성: user_id(익명 가능), device_id, platform, app_version, locale, region_code, network_type

 콘텐츠 공통 속성: content_type, content_id, title(optional), tags, language

B) 핵심 퍼널 정의

말씀 소비 퍼널

sermon_list_viewed

sermon_item_clicked

sermon_detail_viewed

sermon_play_started

sermon_play_25 / 50 / 75 / completed

sermon_bookmarked

sermon_shared

소식 소비 퍼널

news_list_viewed

news_item_clicked

news_detail_viewed

news_shared

커뮤니티 연결 퍼널

community_search_viewed

community_filter_applied

community_item_clicked

community_detail_viewed

community_call_tapped / community_directions_tapped / community_email_tapped

기부 전환 퍼널(MVP)

donate_entry_viewed

donate_webview_opened

donate_external_opened

(가능하면) donate_returned_success (웹에서 콜백/딥링크 있을 때)

알림 퍼널

push_permission_requested / granted / denied

push_topic_enabled/disabled

push_received

push_opened

C) 화면/성능/오류 이벤트

screen_view(home/sermons/news/communities/…)

api_request_failed(endpoint, status_code)

video_playback_error(code)

pdf_open_failed(reason)

app_crash (Crashlytics)

startup_time_ms, home_ttfb_ms

D) 개인정보/민감도 제어

 본문 텍스트(설교/기사 내용) 로그 금지

 이메일/전화번호 수집 금지(분석 이벤트에 포함 X)

 “분석 비활성화” 옵션 제공(설정)

E) 대시보드/리포트 Tasks

 주간 리포트: MAU/리텐션/설교완주율/커뮤니티 전환/기부 유입

 콘텐츠 성과: 설교 TOP10(시청시간 기준), 기사 TOP10(열람)

 알림 성과: 토픽별 클릭률/차단률

Done

각 이벤트가 정확한 시점에 1회만 전송(중복 방지)

퍼널이 대시보드에서 재구성 가능

바로 다음 액션: “작업 티켓” 형태로 쪼개기

원하면 내가 위 Task들을 Jira 티켓처럼 더 쪼개서

티켓명 / 설명 / Subtask / AC / 우선순위 / 의존성(Dependency)
까지 붙여서 “백로그 보드”로 바로 옮길 수 있게 만들어줄게.

그 전에 내가 확정 가정을 하나 깔고 갈게(질문은 안 할게):

MVP는 로그인 없이도 대부분 콘텐츠 소비 가능, 북마크/이어보기는 로컬 저장 → V1에서 계정 동기화

이 가정이 맞다고 치고, 다음 단계로 스프린트별 티켓 100~200개 수준까지 더 세분화해서 계속 내려줄까?

좋아 이제 이 앱개발을 어떻게 할건지 전체적인 아키텍처에 대해서 말해줘

아키텍처는 “모바일 앱(클라이언트) + 콘텐츠 CMS/백엔드(API) + 미디어/문서 저장소 + 검색 + 푸시 + 분석/광고”로 깔끔하게 쪼개는 게 제일 안정적이야. (특히 종교/말씀 앱은 콘텐츠 운영이 핵심이라 CMS 중심으로 설계하는 게 효율 좋음)

아래는 MVP→V1 확장까지 고려한 전체 아키텍처 설계안이야.

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

원하면 다음 단계로, 이 아키텍처를 바탕으로 **“구체 기술 결정(Flutter냐 RN이냐, Strapi냐 Directus냐)”**까지 전제로 두고:

폴더 구조(앱/백엔드)

API 명세(엔드포인트/DTO)

DB ERD(콘텐츠/에셋/번역/이벤트)

배포 다이어그램(Dev/Staging/Prod)
까지 한 번에 더 내려줄게.

전부다 작성해줘 
56s 동안 생각함

좋아. **“폴더 구조(앱/백엔드) + API 명세 + DB ERD + 배포 다이어그램(Dev/Staging/Prod) + CI/CD”**까지, 실제로 개발 가능한 수준으로 한 번에 풀세트로 정리해줄게.
(전제: MVP는 로그인 없이도 대부분 콘텐츠 소비, V1부터 계정/동기화 추가)

0) 최종 기술 스택(확정안) + 이유
모바일

Flutter

iOS/Android 동시 개발, UI 일관성 좋음

영상/오디오/PDF 플러그인 생태계 충분

“차분한 종교 톤” 같은 디자인 시스템 유지가 쉬움

백엔드(BFF/API)

FastAPI (Python) + Postgres + Redis

빠르게 API 만들고, OpenAPI 자동 문서화

홈 피드 집계, 푸시 스케줄링, 검색 인덱싱 같은 서버 로직 구현에 강함

CMS(운영자 콘솔)

Directus(Headless CMS) + Postgres

운영팀이 브라우저에서 콘텐츠 CRUD/검수/다국어 관리 가능

앱은 Directus를 직접 붙이지 않고, FastAPI가 BFF로 단순화된 API를 제공(보안/성능/규칙 강제)

검색

Meilisearch

빠른 도입, 검색 품질/속도 좋고 운영 난이도 낮음

미디어/문서

S3 호환 Object Storage + CDN(CloudFront 등)

영상(HLS), 이미지, PDF를 CDN으로 서빙(서버 부하 최소)

푸시

Firebase Cloud Messaging (FCM) + APNs(iOS)

토픽 구독(sermon/notice/event) + 개별 대상 발송 모두 가능

분석/크래시

Firebase Analytics + Crashlytics

광고(영성 UX 보호)

AdMob Native Ads

홈/목록 최하단 1슬롯만, 상세 본문에는 광고 “구조적으로 불가능하게” 설계

1) 레포지토리(모노레포) 폴더 구조
ffwpu-app/
  README.md
  docs/
    prd.md
    api-spec.md
    erd.md
    architecture.md
    runbooks/
      deploy.md
      backup-restore.md
  apps/
    mobile_flutter/
      pubspec.yaml
      lib/
        main.dart
        app.dart
        core/
          config/           # env, flavor(dev/stage/prod)
          routing/          # go_router
          theme/            # typography/colors/components
          network/          # dio client, interceptors
          storage/          # hive/sqlite wrappers
          analytics/        # firebase wrappers
          errors/           # failure models
          utils/
        features/
          home/
          sermons/
          news/
          events/
          communities/
          media/
          settings/
      test/
      android/
      ios/
  services/
    api_bff_fastapi/
      pyproject.toml
      app/
        main.py
        api/
          v1/
            routes/
              home.py
              sermons.py
              news.py
              events.py
              communities.py
              media.py
              search.py
              push.py
              auth.py
              user.py
            deps.py
        domain/
          models/           # pydantic domain models
          services/         # usecases (home_feed, indexing, push)
        infra/
          db/               # SQLAlchemy models + session
          cache/            # Redis
          cms/              # Directus client
          search/           # Meilisearch client
          storage/          # S3 presign, asset urls
          notifications/    # FCM/APNs
          ads/              # ad placement rules
        jobs/
          scheduler.py      # event reminders
          indexing.py       # publish hook -> meili
        migrations/         # Alembic
        tests/
      docker/
        Dockerfile
    cms_directus/
      docker-compose.yml
      extensions/           # hooks(webhook) optional
  infra/
    docker-compose.dev.yml
    docker-compose.stage.yml
    k8s/                    # 또는 ecs/terraform 선택
      base/
      stage/
      prod/
    terraform/              # (선택) AWS IaC
  .github/
    workflows/
      ci.yml
      deploy-stage.yml
      deploy-prod.yml

2) 모바일(Flutter) 아키텍처 상세
2.1 상태관리/라우팅/네트워크

상태관리: Riverpod

라우팅: go_router

네트워크: Dio

로컬저장:

MVP: Hive(빠르고 단순) + 필요시 SQLite로 확장

이어보기/북마크는 로컬 저장 → V1에서 계정 동기화

2.2 앱 내부 레이어(Feature 단위)

각 feature는 동일 패턴:

features/sermons/
  data/
    sermon_api.dart           # API 호출
    sermon_repository_impl.dart
    models_dto.dart
  domain/
    sermon.dart               # entity
    get_sermons_usecase.dart
  presentation/
    sermon_list_screen.dart
    sermon_detail_screen.dart
    widgets/

2.3 공통 UX 규칙(영성 보호)

“조용한 모드” 설정:

설교 재생 중: 상단 배너/프로모션 숨김

알림/광고 노출 최소화

광고 정책을 클라이언트에서도 2중 방어:

상세 화면에는 AdWidget 자체가 존재하지 않음(구조적으로 배제)

3) 백엔드(BFF) 아키텍처 상세
3.1 BFF가 하는 일

Directus(CMS)에서 데이터를 가져와 모바일에 최적화된 형태로 변환/집계

홈 피드 /home-feed에서 Sermon/News/Event/Community를 한 번에 내려줌

Meilisearch 인덱싱/검색 제공

푸시 스케줄링(행사 리마인더)

캐시(Redis)로 목록/홈 피드 응답 가속

광고 슬롯을 “홈/목록만” 내려줌(상세는 아예 필드 없음)

3.2 Directus와의 연결 방식

BFF는 Directus REST API를 호출하거나, 같은 Postgres를 직접 읽을 수 있음

권장: Directus API 호출 (권한/필터/다국어 처리 일관성)

발행 트리거:

Directus hook/webhook → BFF /admin/hooks/published 호출

BFF가 캐시 무효화 + 검색 인덱싱 + (옵션) 푸시 큐 등록

4) API 명세(실제 개발용)

아래는 MVP 기준(로그인 없이 가능) + V1 확장 포함.

4.1 공통 규칙

Base: /api/v1

페이징: cursor 기반

정렬: sort=recent|popular|oldest

필터: category, year, tag, language, region

에러 포맷(통일):

{
  "error": {
    "code": "SERMON_NOT_FOUND",
    "message": "요청한 콘텐츠를 찾을 수 없습니다.",
    "request_id": "abc-123"
  }
}

4.2 Home
GET /home-feed

Response

{
  "hero": { "text": "오늘의 묵상 한 문장", "source": "..." },
  "sections": [
    { "type": "sermons", "title": "최신 말씀", "items": [/* sermon_preview */] },
    { "type": "news", "title": "최근 소식", "items": [/* news_preview */] },
    { "type": "events", "title": "다가오는 행사", "items": [/* event_preview */] },
    { "type": "communities", "title": "커뮤니티 찾기", "items": [/* community_preview */] },
    { "type": "ad_slot", "slot_id": "home_bottom_1" }
  ]
}

4.3 Sermons (말씀/설교)
GET /sermons

Query: query, category, year, tag, language, sort, cursor, limit

{
  "items": [
    {
      "id": "serm_123",
      "title": "주일 설교 제목",
      "speaker": "설교자",
      "date": "2026-01-18",
      "duration_sec": 1800,
      "thumbnail_url": "https://cdn/...jpg",
      "tags": ["Sunday", "Family"]
    }
  ],
  "next_cursor": "..."
}

GET /sermons/{id}
{
  "id": "serm_123",
  "title": "주일 설교 제목",
  "speaker": "설교자",
  "date": "2026-01-18",
  "summary": "요약...",
  "transcript": "전문 텍스트...",
  "media": {
    "video_hls_url": "https://cdn/...m3u8",
    "audio_url": "https://cdn/...mp3",
    "thumbnail_url": "https://cdn/...jpg"
  },
  "related": [
    { "type": "sermon", "id": "serm_99", "title": "관련 설교" }
  ]
}


중요: /sermons/{id}에는 광고 관련 필드가 절대 존재하지 않음.

4.4 Speeches(연설 아카이브, V1~)
GET /speeches
GET /speeches/{id}
4.5 News (소식/공지/칼럼)
GET /news

Query: category=notice|news|column, query, tag, language, cursor

GET /news/{id}
{
  "id": "news_1",
  "category": "notice",
  "title": "공지 제목",
  "published_at": "2026-01-10T09:00:00Z",
  "body": "<p>HTML 또는 Markdown 렌더용</p>",
  "cover_url": "https://cdn/...",
  "tags": ["Announcement"]
}

4.6 Events (행사/캘린더)
GET /events

Query: from, to, region, query, cursor

GET /events/{id}
{
  "id": "evt_77",
  "title": "행사명",
  "start_at": "2026-02-01T10:00:00+09:00",
  "end_at": "2026-02-01T12:00:00+09:00",
  "location": {
    "name": "장소",
    "address": "주소",
    "lat": 37.123,
    "lng": 127.456
  },
  "registration_url": "https://...",
  "contact": { "phone": "...", "email": "..." }
}

4.7 Communities (교회/커뮤니티 찾기)
GET /communities

Query: region_code, query, lat, lng, radius_km, cursor

GET /communities/{id}
4.8 Media / Publications
GET /publications
GET /publications/{id}
{
  "id": "pub_10",
  "title": "True Peace 2026-01",
  "published_at": "2026-01-01",
  "cover_url": "https://cdn/...",
  "pdf_url": "https://cdn/...pdf",
  "rights_note": "배포 권리 안내 문구"
}

4.9 Search
GET /search

Query: q, types=sermon,news,event,community,publication, language, cursor

{
  "items": [
    { "type": "sermon", "id": "serm_1", "title": "...", "highlight": "..." }
  ],
  "next_cursor": "..."
}

4.10 Push (디바이스 토큰/구독)
POST /push/register
{ "device_id": "xxx", "platform": "ios", "token": "fcm...", "locale": "ko-KR" }

POST /push/subscriptions
{ "topics": { "sermon": true, "notice": false, "event_reminder": true } }

4.11 Ads (서버가 슬롯만 정의)
GET /ads/slots?screen=home|sermon_list|news_list
{
  "slots": [
    {
      "slot_id": "home_bottom_1",
      "format": "native",
      "policy": { "max_per_day": 20, "no_detail_pages": true }
    }
  ]
}

5) DB 스키마 + ERD(관계까지)
5.1 핵심 설계: “content_items”로 통합(추천)

Sermon/News/Event/Publication 등을 공통 테이블로 묶어두면:

북마크/검색/다국어/태그가 쉬워짐

“콘텐츠 타입이 늘어나도” 설계가 흔들리지 않음

주요 테이블 목록

content_items (공통 메타)

sermon_details

news_details

event_details

community_details

publication_details

assets (이미지/영상/PDF)

tags, content_tags

localizations (다국어)

users(V1), user_bookmarks, user_continue_watching, device_tokens

reports/corrections(V1)

5.2 ERD(mermaid)
erDiagram
  CONTENT_ITEMS ||--o{ LOCALIZATIONS : has
  CONTENT_ITEMS ||--o{ CONTENT_TAGS : tagged
  TAGS ||--o{ CONTENT_TAGS : used_by

  CONTENT_ITEMS ||--o| SERMON_DETAILS : sermon
  CONTENT_ITEMS ||--o| NEWS_DETAILS : news
  CONTENT_ITEMS ||--o| EVENT_DETAILS : event
  CONTENT_ITEMS ||--o| COMMUNITY_DETAILS : community
  CONTENT_ITEMS ||--o| PUBLICATION_DETAILS : publication

  ASSETS ||--o{ CONTENT_ITEMS : cover_asset
  ASSETS ||--o{ SERMON_DETAILS : media_asset
  ASSETS ||--o{ PUBLICATION_DETAILS : pdf_asset

  USERS ||--o{ USER_BOOKMARKS : bookmarks
  USERS ||--o{ USER_CONTINUE : continues
  USERS ||--o{ DEVICE_TOKENS : devices

  CONTENT_ITEMS ||--o{ USER_BOOKMARKS : bookmarked
  CONTENT_ITEMS ||--o{ USER_CONTINUE : continued

  CONTENT_ITEMS {
    uuid id PK
    string type  "sermon/news/event/community/publication"
    string slug
    string status "draft/review/published/archived"
    string language_default
    uuid cover_asset_id FK
    timestamp published_at
    timestamp created_at
    timestamp updated_at
  }

  LOCALIZATIONS {
    uuid id PK
    uuid content_id FK
    string language
    string title
    string summary
    text body
  }

  SERMON_DETAILS {
    uuid content_id PK,FK
    string speaker
    date sermon_date
    int duration_sec
    uuid video_asset_id FK
    uuid audio_asset_id FK
    text transcript
  }

  NEWS_DETAILS {
    uuid content_id PK,FK
    string category "notice/news/column"
    text body_html
    string source_url
  }

  EVENT_DETAILS {
    uuid content_id PK,FK
    timestamp start_at
    timestamp end_at
    string timezone
    string location_name
    string address
    float lat
    float lng
    string registration_url
    string contact_phone
    string contact_email
    string region_code
  }

  COMMUNITY_DETAILS {
    uuid content_id PK,FK
    string name
    string region_code
    string address
    float lat
    float lng
    string phone
    string email
    json service_times
  }

  PUBLICATION_DETAILS {
    uuid content_id PK,FK
    string issue
    uuid pdf_asset_id FK
    string rights_note
  }

  ASSETS {
    uuid id PK
    string type "image/video/audio/pdf"
    string url
    string mime_type
    bigint size_bytes
    int width
    int height
    int duration_sec
    string checksum
    timestamp created_at
  }

  TAGS {
    uuid id PK
    string name
  }

  CONTENT_TAGS {
    uuid content_id FK
    uuid tag_id FK
  }

  USERS {
    uuid id PK
    string email
    string display_name
    string role
    string region_preference
    string language_preference
    timestamp created_at
  }

  USER_BOOKMARKS {
    uuid user_id FK
    uuid content_id FK
    timestamp created_at
  }

  USER_CONTINUE {
    uuid user_id FK
    uuid content_id FK
    int position_sec
    timestamp updated_at
  }

  DEVICE_TOKENS {
    uuid id PK
    uuid user_id FK
    string device_id
    string platform
    string token
    string locale
    timestamp updated_at
  }

6) 배포 아키텍처(Dev / Staging / Prod) + 다이어그램
6.1 환경별 목표

Dev: 로컬에서 빠르게 개발(도커 컴포즈)

Staging: 운영과 거의 동일, QA/테스트/콘텐츠 검수

Prod: 고가용성/백업/모니터링/보안 강화

6.2 Dev (Local Docker Compose)
[Flutter App] -> [FastAPI(local)] -> [Directus(local)] -> [Postgres(local)]
                               -> [Redis(local)]
                               -> [Meilisearch(local)]
Assets: local minio(S3) optional


infra/docker-compose.dev.yml로 한 번에 띄움

더미 데이터 시딩 스크립트 포함

6.3 Staging (클라우드 단일 AZ + 최소 규모)
Route53
  -> ALB (HTTPS)
      -> ECS/Fargate:
          - api-bff-fastapi
          - directus
          - meilisearch
      -> RDS Postgres (small)
      -> ElastiCache Redis (small)
S3 + CloudFront (assets)
Firebase (push/analytics)


운영팀이 콘텐츠를 올리고 QA가 실제 앱으로 검수

푸시 발송도 staging 토픽으로 분리(sermon_stage)

6.4 Prod (멀티 AZ + 확장)
Route53 + WAF
  -> ALB (HTTPS, ACM)
      -> ECS/Fargate (AutoScaling)
          - api-bff-fastapi (N copies)
          - directus (N copies or 1 w/ HA strategy)
          - worker/scheduler (indexing, reminders)
      -> RDS Postgres (Multi-AZ, backups)
      -> ElastiCache Redis (replication)
      -> OpenSearch/Meilisearch (HA 구성)
S3 (versioning) + CloudFront CDN
Secrets Manager / Parameter Store
CloudWatch + Sentry(optional) + Firebase

7) CI/CD 파이프라인(실제 운영 수준)
7.1 GitHub Actions 예시 흐름
CI (Pull Request)

Flutter: format/lint/test/build

FastAPI: lint(ruff)/test/typing/migrations check

Docker: 이미지 빌드 테스트

Deploy Staging (main 브랜치 merge)

도커 이미지 build → registry push

DB migration(Alembic) 실행

ECS 서비스 업데이트(rolling)

스모크 테스트 /health, /home-feed

Deploy Prod (tag/release)

승인(Manual approval)

동일 절차 + canary/rolling + 모니터링 알람

8) 실행 가능한 운영 규칙(런북 핵심)
8.1 캐시/무효화

홈 피드: 5~10분 캐시

목록: 1~5분 캐시

발행 이벤트 발생 시:

해당 타입 캐시 무효화

검색 인덱싱 업데이트

푸시 옵션 있으면 큐 등록

8.2 백업/복구

RDS 자동 백업(일 단위)

S3 versioning + lifecycle

월 1회 복구 리허설(runbook)

8.3 관측/알람

API p95 latency, 5xx 비율, DB 커넥션 수

푸시 성공률, 검색 인덱싱 실패율

앱 크래시율(Crashlytics)

9) “전부” 산출물 체크리스트(바로 개발 착수용)
모바일

 디자인 시스템(색/타이포/컴포넌트)

 화면: Home, Sermons(list/detail), News(list/detail), Communities(list/detail), Publications(list/viewer), Settings

 로컬: 이어보기/북마크/설정

 푸시 수신/딥링크 오픈

 이벤트 트래킹(Firebase)

서버

 FastAPI BFF + Redis 캐시

 Directus CMS(콘텐츠 타입/권한/검수 상태)

 Meilisearch 인덱스 + 검색 API

 publish hook → 캐시 무효화/인덱싱/푸시 큐

 scheduler(행사 리마인더)

인프라

 dev/stage/prod 구성

 CI/CD

 모니터링/백업/보안(WAF/Secrets)