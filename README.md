# pyroscope-demo

This repo is a demo integration of pyroscope, grafana and a java microservice.

![image](https://github.com/rcasia/pyroscope-demo/assets/31012661/b2d7dee3-7047-4ab6-9b53-10fa325fad8e)

# Local deploy

1. Run `docker compose up --build`.
2. Go to `http://localhost:3000/datasources` and add Pyroscope with url `http://localhost:4040`.
3. Go to `http://localhost:3000/explore`, choose the pyroscope datasource.
4. Run some queries ;)
