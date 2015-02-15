all: build

build: 
	docker build -t cloudgear/ruby:2.1 .