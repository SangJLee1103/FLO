# FLO App
> 프로그래머스의 과제테스트로 음악 서비스인 FLO App을 클론합니다.
https://school.programmers.co.kr/skill_check_assignments/2



<img src="https://user-images.githubusercontent.com/76645463/204215310-09b6fa9a-4ad8-4828-a340-7ab67ec73b7b.png" width="300" height="650">  <img src="https://user-images.githubusercontent.com/76645463/204215318-434774a0-3c53-4346-9cc0-ca166dc70821.png" width="300" height="650">

## 화면 구성

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
- MVVM 디자인 패턴 
  - Observable객체를 구현하여 변화화는 값을 관찰하도록 하였고, 이를 통해 데이터 바인딩을 구현하였습니다. 
