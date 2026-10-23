# CAC 관련 데모 출처와 실제 접근 상태
확인일 2026-10-22. 이 파일은 실제영상 관찰보고서가 아니다. 공식문서의 앱내용, 링크확인, 재생성공 여부를 분리한다. 관련 보험/문서제출 전용 수상작을 임의로 만들어 넣지 않았다.

| 사례 | 공식 수상 근거/관련성 | 영상 링크 | 확인한 범위 | 미확인 |
|---|---|---|---|---|
| Healthbridge US, 2025 NY03 우승 | 공식CAC: underinsured 이용자의 의료기관/보험정보 접근 지원 | https://www.youtube.com/watch?v=IIlGk1cD3Ko | 공식embed와 브라우저 제목 확인, 표시길이7:10. 제목 HealthBridge Introduction of WebPage for Congressional App Challenge | 프레임 재생안됨. 제출용3분영상 여부/구간/시선/무빙/코드노출 미확인 |
| Homonium, 2024 TX37 우승 | 공식CAC: 취약·이민가정 법률접근 지원 | https://www.youtube.com/watch?v=EQjCyOr7ZAI | 공식embed영상ID·메타데이터 확인 | 미디어가 실제영상 대신 접근불가응답. 장면/리듬/카메라 미확인 |
| LegalEase, 2025 FL20 우승 | 공식CAC: 청소년 권리/시민교육, 문서제출앱과는다름 | https://player.vimeo.com/video/1131928863?byline=0&fe=ci&fl=sv&h=&pip=1&playsinline=1&portrait=0&share=copy&title=0 | 공식embed·Vimeo제목 확인 | 빈플레이어/미디어미확보. 실물분석미완료 |
| TosNOW, 2024 CA50 4위 | 의원실발표: 약관/개인정보문서 요약, 지역구대표우승작은 CheckPoint Student | https://www.youtube.com/embed/g_jZnqYob1o&t=1s | 의원실HTML에서링크·순위확인 | 프레임미확보. 지역구우승으로 부르지않음 |
| Cal Capture, 2024 LA04 1위 | 의원실발표: 종이날짜를달력으로 OCR/ML 전환 | 공식발표참조, 영상미확보 | 문서자동화 유사기능 확인 | 영상URL/실제시연 미확인 |

공식출처:
- https://www.congressionalappchallenge.us/25-ny03/
- https://www.congressionalappchallenge.us/24-tx37/
- https://www.congressionalappchallenge.us/25-fl20/
- https://scottpeters.house.gov/press-releases/rep-scott-peters-announces-congressional-app-challenge-winners
- https://mikejohnson.house.gov/news/documentsingle.aspx?DocumentID=1520

## 재생 검증에서 확인한 사실
Healthbridge의 브라우저 플레이어는 0:00/7:10과 제목이 보였으나 재생시각0초, readyState0으로 실제프레임이 나타나지 않았다. 따라서 검은 플레이어화면은 영상 내용이 아니라 접근 실패다. 7:10짜리 링크를 CAC권장제출길이의 예로 일반화하지 않는다.
공개 영상 메타데이터/썸네일시트/미디어경로도 확인을 시도했으나 실제 이미지/영상바이트가 아닌 접근불가응답이어서 시각분석에 사용하지 않았다. 다운로드툴의 완료표시만으로 영상확보를 주장하지 않았다. Vimeo 대체경로도 영상미디어를 얻지 못했다. 제한우회/로그인/불필요반복시도는 중단했다.

## 실제 영상 분석을 완료하는 최소 입력
사용자가 공개된 원본MP4/WebM/MOV를 파일로 제공하면 로컬 분석가능. 각관련영상 2~3개만 있으면 충분하다. URL/대본/썸네일만으로는 시선·움직임·구간컷을 관찰할 수 없다.
파일 확보 후: ①ffprobe길이/프레임 ②5~10초간격contactsheet ③전환부2초간격추가 ④필요장면실시간재생 ⑤timecode/shot별관찰과추론분리 ⑥기술구간에실제코드가보였는지기록. 프레임샘플만봤다면 연속시청으로부르지않음.
본패키지의 Filming Reference Guide는 CoverNote제작권장안이다. 수상영상의실제관찰로위장하지않는다. 영상확보전 actual_video_observation_status=BLOCKED_MEDIA_ACCESS.
