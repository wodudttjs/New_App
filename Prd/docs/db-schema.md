# DB/콘텐츠 스키마 (제안)

> MVP 기준, V1 확장 고려

## users (V1)
- id (pk)
- email
- provider
- created_at

## user_bookmarks (V1)
- user_id (fk users.id)
- content_type
- content_id
- created_at

## user_continue_watching (V1)
- user_id (fk users.id)
- content_id
- position_sec
- updated_at

## sermons
- id (pk)
- slug
- title
- speaker
- date
- duration_sec
- summary
- transcript
- video_url
- audio_url
- thumbnail_asset_id
- tags[]
- language
- status
- published_at

## news
- id (pk)
- category (notice/news/column)
- title
- summary
- body_html
- cover_asset_id
- tags[]
- language
- published_at
- source_url

## events
- id (pk)
- title
- summary
- start_at
- end_at
- location_name
- address
- region_code
- tags[]
- cover_asset_id
- contact (json)

## communities
- id (pk)
- name
- region_code
- address
- lat
- lng
- phone
- email
- website
- service_times (json)
- description
- thumbnail_asset_id
- updated_at

## publications
- id (pk)
- title
- issue
- published_at
- cover_asset_id
- pdf_asset_id
- language
- tags[]
- rights_note

## assets
- id (pk)
- type (image/video/audio/pdf)
- url
- mime_type
- size_bytes
- width
- height
- duration_sec
- checksum
- created_at

## content_localizations
- id (pk)
- content_type
- content_id
- language
- localized_title
- localized_body
- created_at

## push_devices
- id (pk)
- device_id
- platform
- token
- locale
- updated_at

## push_subscriptions
- device_id
- topics (json)
- updated_at
