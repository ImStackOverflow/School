PROGRAM=/home/gchen/GitShit/cs128
IP1=10.0.0.20
IP2=10.0.0.21
IP3=10.0.0.22
IP4=10.0.0.23
NODES=$(IP1) $(IP2) $(IP3) $(IP4)
VIEW=$(IP1):8080,$(IP2):8080,$(IP3):8080,$(IP4):8080
NAME=hw3
K=2

prune:
	docker image prune
	docker container prune

stop:
	docker stop $$(docker ps -q)

build:
	docker build -t $(NAME) $(PROGRAM)

#make 3 nodes
start: build
	docker run -d -p 8080:8080 --net=mynet --ip=$(IP1) --name=$(IP1) --mount type=bind,source=$(PROGRAM),target=/app -e K=$(K) -e VIEW=$(VIEW) -e "ip_port"=$(IP1):8080 $(NAME) 
	docker run -d -p 8081:8080 --net=mynet --ip=$(IP2) --name=$(IP2) --mount type=bind,source=$(PROGRAM),target=/app -e K=$(K) -e VIEW=$(VIEW) -e "ip_port"=$(IP2):8080 $(NAME) 
#	docker run -d -p 8082:8080 --net=mynet --ip=$(IP3) --name=$(IP3) --mount type=bind,source=$(PROGRAM),target=/app -e K=$(K) -e VIEW=$(VIEW) -e "ip_port"=$(IP3):8080 $(NAME)
#	docker run -d -p 8083:8080 --net=mynet --ip=$(IP4) --name=$(IP4) --mount type=bind,source=$(PROGRAM),target=/app -e K=$(K) -e VIEW=$(VIEW) -e "ip_port"=$(IP4):8080 $(NAME)  

#use this to refresh code changes instead of building new image
restart:
	docker restart $$(docker ps -q)

#use this when u type a retarded fucking error and the code doesnt compile and shuts down the container
bootup:
	for bitch in $(NODES) ; do \
		docker start $$bitch ; \
	done

target:
	for number in 1 2 3 4 ; do \
		echo $$number ; \
	done
