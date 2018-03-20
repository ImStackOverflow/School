PROGRAM=~/GitShit/cs128
NODES="1 2"
VIEW=""
NAME=hw3

#docker build -t $NAME $PROGRAM

view:
	for i in $NODES
	do
	VIEW="10.0.0.2$i:8080,$VIEW"
	done

start: view
	for i in $NODES
	do
	docker run -p 808$i:8080 -v $PROGRAM --net=mynet --ip=10.0.0.2$i -e VIEW="$VIEW" -e "ip_port"="10.0.0.2$i:8080" -d $NAME
	done

restart:
	docker restart $(docker ps -q)
