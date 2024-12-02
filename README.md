# pLannotate API

A simple FastAPI in docker to use pLannotate.


Local dependency management:

```bash
poetry add git+https://github.com/manulera/pLannotate --extras api
pip freeze > requirements.txt
```

Build and run image:

```bash
docker build --platform linux/amd64 -t manulera/plannotate-api .

# Run
docker run -d --name plannotate-api -p 8000:8000 manulera/plannotate-api

# Push to docker hub
docker push manulera/plannotate-api
```

Go to http://localhost:8000 to see the API documentation.