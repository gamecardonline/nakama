PROJECT_NAME=github.com/gamecardonline
APP_PATH=$(PWD)/..

build-cross:
	go mod vendor
	docker run -it --rm \
	  --platform linux/amd64 \
      -v ${APP_PATH}:/go/src/${PROJECT_NAME} \
      -w /go/src/${PROJECT_NAME}/nakama \
      docker.elastic.co/beats-dev/golang-crossbuild:1.18-main \
      --build-cmd "make build-nakama" \
      -p "linux/amd64"
build-nakama:
		CGO_ENABLED=1 GOOS=linux GOARCH=amd64 go build -trimpath -mod=vendor
