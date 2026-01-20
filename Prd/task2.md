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