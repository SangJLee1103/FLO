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

## 프레임워크
- UIKit
- AVFoundation

## 사용기술
- **MVVM 디자인패턴** 
  - ![다운로드](https://user-images.githubusercontent.com/76645463/204228565-b6f46f4a-59f0-4d9c-80d1-496d61f7102c.png)
  - Observable 객체를 생성하여 변화하는 값에 대해 관찰하도록 하여, **데이터바인딩**을 구현하였습니다.

