AWS_PROFILE_NAME :=
AWS_REGION       :=
AWS_PROJECT_ID   :=
ECR_REPOSITORY   :=

.PHONY: api build up down auth push
api:
	air -c .air.toml

build:
	docker-compose build

up:
	docker-compose -f docker-compose.yml up -d
	docker-compose -f docker-compose.yml logs -f

down:
	docker-compose -f docker-compose.yml down

auth:
	@echo "===============[ Authenticating with AWS ECR ]==============="
	aws ecr get-login-password --region ${AWS_REGION} --profile ${AWS_PROFILE_NAME} | docker login --username AWS --password-stdin ${AWS_PROJECT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

push: build auth
	@echo "===============[ Building and pushing the docker image to AWS ECR ]==============="
	docker build -f ./docker/backend/api/Dockerfile -t ${ECR_REPOSITORY} .
	docker tag ${ECR_REPOSITORY}:latest ${AWS_PROJECT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest
	docker push ${AWS_PROJECT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest
