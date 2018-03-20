import requests

if __name__ == "__main__":
	print("http://localhost:8080/kvs/view_update?ip_port=0.0.0.0:8083&type=add")
	p = requests.put("http://localhost:8080/kvs/view_update?ip_port=0.0.0.0:8083&type=add")
	print(p.content)

	print("http://localhost:8080/kvs/view_update?ip_port=0.0.0.0:8081&type=add")
	p = requests.put("http://localhost:8080/kvs/view_update?ip_port=0.0.0.0:8081&type=add")
	print(p.content)

	print("http://localhost:8080/kvs/view_update?ip_port=0.0.0.0:8084&type=add")
	p = requests.put("http://localhost:8080/kvs/view_update?ip_port=0.0.0.0:8084&type=add")
	print(p.content)

	print("http://localhost:8080/kvs/view_update?ip_port=0.0.0.0:8082&type=add")
	p = requests.put("http://localhost:8080/kvs/view_update?ip_port=0.0.0.0:8082&type=add")
	print(p.content)
