AWS_PROFILE_NAME :=
AWS_REGION       :=
AWS_PROJECT_ID   :=
ECR_REPOSITORY   :=

.PHONY: api build run clean auth push
api:
	air -c .air.toml

build:
	@echo "===============[ Building the docker image ]==============="
	docker build -f ./docker/backend/api/Dockerfile -t api .

run: build
	@echo "===============[ Running the docker container ]==============="
	docker run -d -p 8080:8080 api

clean:
	@echo "===============[ Stopping and removing the docker container ]==============="
	docker stop $(shell docker ps -a -q)
	docker rm $(shell docker ps -a -q)

auth:
	@echo "===============[ Authenticating with AWS ECR ]==============="
	aws ecr get-login-password --region ${AWS_REGION} --profile ${AWS_PROFILE_NAME} | docker login --username AWS --password-stdin ${AWS_PROJECT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

push: build auth
	@echo "===============[ Building and pushing the docker image to AWS ECR ]==============="
	docker build -f ./docker/backend/api/Dockerfile -t ${ECR_REPOSITORY} .
	docker tag ${ECR_REPOSITORY}:latest ${AWS_PROJECT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest
	docker push ${AWS_PROJECT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest
