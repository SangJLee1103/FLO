# FLO App
> 프로그래머스의 과제테스트로 음악 서비스인 FLO App을 클론합니다.<br>
https://school.programmers.co.kr/skill_check_assignments/2

<img src="https://img.shields.io/badge/Swift-orange?style=flat-square&logo=Swift&logoColor=white"/>

<img src="https://user-images.githubusercontent.com/76645463/204215310-09b6fa9a-4ad8-4828-a340-7ab67ec73b7b.png" width="300" height="650">  <img src="https://user-images.githubusercontent.com/76645463/204215318-434774a0-3c53-4346-9cc0-ca166dc70821.png" width="300" height="650">

## 화면구성

- 스플래시 스크린

- 음악 재생 화면
  - 재생 중인 음악 정보(제목, 가수, 앨범 커버 이미지, 앨범명)
  - 현재 재생 중인 부분의 가사 하이라이팅
  - Seekbar
  - Play/Stop 버튼
- 전체 가사 보기 화면
  - 특정 가사로 이동할 수 있는 토글 버튼
  - 전체 가사 화면 닫기 버튼
  - Seekbar
  - Play/Stop 버튼



## 사용기술
<img src="data:image/png;base64,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" width:"600" height="300">


- **MVVM 디자인패턴**
  - Observable 객체를 생성하여 변화하는 값에 대해 관찰하도록 하여, **데이터바인딩**을 구현하였습니다.

