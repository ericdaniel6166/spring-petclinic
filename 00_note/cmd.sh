#docker login

docker pull maven:3.8.3-amazoncorretto-17
docker pull amazoncorretto:17-alpine-jdk
########################################################################
SPRING_PET_CLINIC_VERSION="1.0"
docker build -t eric6166/spring-petclinic:${SPRING_PET_CLINIC_VERSION} .
docker run -d -p 8080:8080 eric6166/spring-petclinic:${SPRING_PET_CLINIC_VERSION}
docker push eric6166/spring-petclinic:${SPRING_PET_CLINIC_VERSION}

mvn spring-boot:run -Dspring-boot.run.profiles=postgres
#mvn spring-boot:run -B -Dspring-boot.run.profiles=postgres
########################################################################
docker compose up -d
