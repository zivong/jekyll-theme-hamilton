---
layout: post
title: java
categories: study
---


# 오프라인 메이븐 프로젝트 생성&배포

- 폐쇄망 환경에서 개발할 경우 
- 빌드 시 로컬 레파지토리를 사용할 경우

### 필요한 라이브러리 maven repository 에 추가하기
+ 외부 라이브러리를 다운로드 받아 로컬 메이븐 레파지토리에 두고 pom.xml 에서 사용할 것임

  1. 아파치 commons-compress-1.21.jar 다운로드 
  2. mvn install
```
mvn install:install-file -Dfile=C:\Users\Admin\Desktop\common-compress-1.21.jar -DgroupId=common-compress -DartifactId=common-compress -Dversion=1.21 -Dpackaging=jar -DgeneratePom=true
```
  3. 로컬 maven repository/groupId/artifactId 경로에 jar 및 pom정보 파일 생성됨
    => .pom 정보는 pom.xml에 추가할 정보


### pom.xml 라이브러리 설정
+ 로컬 레파지토리 설정
+ 추가된 외부 라이브러리 dependency 설정
+ 배포할 시스템에 있는 라이브러리 :: 빌드시 패키지에서 제외되게 설정
```
<repositories>
  <repository>
    <id>local-repository</id>
    <name>local repository</name>
    <url>file://C:/Users/Admin/.m2/repository
  </repository>
</repositories>

<dependencies>
<!-- 중략(기타 라이브러리 설정) -->
    
    <!-- 메이븐 레파지토리 -->
    <!-- common-compress -->
    <dependency>
      <groupId>common-compress</groupId>
      <artifactId>common-compress</artifactId>
      <version>1.21</version>
    </dependency>
    
    <!-- 배포할 서버 lib 에 존재 + 프로젝트 lib에 존재하는 라이브러리 :: 빌드시 패키지에서 제외됨 -->
    <!-- log4j -->
    <dependency>
      <groupId>org.apache</groupId>
      <artifactId>log4j</artifactId>
      <version>1.2.15</version>
      <scope>system</scope>
      <systemPath>${project.basedir}/lib/log4j-1.2.15.jar</systemPath>
  </dependency>
    
</dependencies>
```

### pom.xml 빌드 플러그인 설정

```
<build>
  <sourceDirectory>src</sourceDirectory>
  <plugins>
    <plugin>
      <artifactId>maven-compiler-plugin</artifactId>
      <version>3.8.0</version>
      <configuration>
        <source>1.8</source>
        <target>1.8</target>
      </configuration>
    </plugin>
    
     <!-- jar 생성시 maven 의존lib 도 함께 패키징. mvn Goals => assembly:assembly -->
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-assembly-plugin</artifactId>
      <version>2.2.1</version>
      <configuration>
        <descriptorRefs>
          <descriptorRef>jar-with-dependencies</descriptorRef>
        </descriptorRefs>
      </configuration>
    </plugin>
    
    <!-- 라이브러리 관리 : 의존lib 를 따로 빼서 outputDirectory에 저장한다. mvn Goals => dependency:copy-dependencies-->
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-dependency-plugin</artifactId>
      <version>2.3</version>
      <executions>
        <execution>
          <id>copy-dependencies</id>
          <phase>package</phase>
          <goals>
            <goal>copy-dependencies</goal>
          </goals>
        </execution>
      </executions>
      <configuration>
        <outputDirectory>target/dependencies</outputDirectory>
        <overWriteIfNewer>true</overWriteIfNewer>
      </configuration>
    </plugin>  
  </plugins>
</build>

<!-- 후략 -->
```


### 빌드하기 (Eclipse 환경)
1. Build Goals 에 assembly:assembly 세팅후 Run
2. target 폴더에 프로젝트id-jar-with-dependencies.jar 생성됨
3. 배포할 시스템 lib 폴더에 두고 사용


       
       
       

       
       
