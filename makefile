
run:
	docker-compose up -d

clean:
	sudo rm -rf mount_points/*
	sudo rm -rf minio/.minio.sys
