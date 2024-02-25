AWS_PROFILE_NAME :=
AWS_REGION       :=
AWS_PROJECT_ID   :=
ECR_REPOSITORY   :=
LAMBDA_FUNCTION  :=

.PHONY: api build run clean auth update
api:
	air -c .air.toml

build:
	docker build --platform linux/amd64 -f ./docker/backend/api/Dockerfile -t ${ECR_REPOSITORY} .

run: build
	docker run -d -p 8080:8080 ${ECR_REPOSITORY}

clean:
	docker stop $(shell docker ps -a -q)
	docker rm $(shell docker ps -a -q)

auth:
	aws ecr get-login-password --region ${AWS_REGION} --profile ${AWS_PROFILE_NAME} | docker login --username AWS --password-stdin ${AWS_PROJECT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

update: build auth
	docker tag ${ECR_REPOSITORY}:latest ${AWS_PROJECT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest
	docker push ${AWS_PROJECT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest
	aws lambda update-function-code --function-name ${LAMBDA_FUNCTION} --image-uri ${AWS_PROJECT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest --region ${AWS_REGION} --profile ${AWS_PROFILE_NAME}
