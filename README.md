## 사이트 설정
sites-available 디렉토리 내부에 [sample.com.conf](https://github.com/suhoag/docker-hiworks-api-dev/blob/master/sites-available/sample.com.conf)참고

## 실행전 준비

### 공유 폴더
- 도커와 미리 공유 폴더 연결 /c/Users (docker-machine 기본 공유), /source

### 설정 폴더
- 설정을 저장할 아래 디렉토리 준비. 디렉토리는 달라져도 상관없음

```
/c/Users/user1/docker/dev/sites-available
/c/Users/user1/docker/dev/sites-available
```

## docker 실행
```
docker run -d --name dev \
    -p 80:80 \
    -p 443:443 \
    -v /source:/var/www \
    -v /c/Users/user1/docker/dev/sites-available:/etc/apache2/sites-available \
    -v /c/Users/user1/docker/dev/certificate:/etc/apache2/certificate \
    suhoag/hiworks-api-dev
```

## 사이트 활성화
- dev 는 위의 docker 실행시 --name 으로 지정한 컨데이너 이름
- sample.com 은 사이트 설정 파일의 이름. sample.com.conf 라고 해도 무관.

```
-- sample.com은 설정 파일에 지정한 도메인명
docker exec dev a2ensite sample.com
docker exec dev service apache2 reload 
```

## IP 주소 확인
```
docker-machine ip
```

## HOST 설정
- 192.168.99.104 는 위의 docker-machine ip 명령어에서 나온 IP 로 변경

```
192.168.99.104 sample.com
```