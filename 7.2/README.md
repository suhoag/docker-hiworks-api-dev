## 개요
apache2 서버만 설치된 컨테이너

## 실행전 준비

### 공유 폴더
- 도커와 미리 공유 폴더 연결 되어 있음 /c/Users (docker-machine 기본 공유)
- c:\Users 폴더 하위에 설정, 소스등을 두는 것이 편함

### 설정 폴더
- 설정을 저장할 아래 디렉토리 준비. 디렉토리는 달라져도 상관없음

```
/c/Users/user1/docker/dev/sites-enabled
/c/Users/user1/docker/dev/certificate 
```

### 사이트 설정 파일 예제
sites-enabled_sample 디렉토리 내부에 [sample.com.conf](https://github.com/suhoag/docker-hiworks-api-apache-dev/blob/master/sites-enabled_sample/sample.com.conf)참고

## 사이트 활성화
- dev 는 위의 docker 실행시 --name 으로 지정한 컨데이너 이름
- sample.com 은 사이트 설정 파일의 이름. sample.com.conf 라고 해도 무관.

```
-- sample.com은 설정 파일에 지정한 도메인명
docker exec dev service apache2 reload 
```

## IP 주소 확인
```
docker-machine ip
```

## HOST 설정
- 192.168.99.100 는 위의 docker-machine ip 명령어에서 나온 IP 로 변경

```
192.168.99.100 sample.com
```