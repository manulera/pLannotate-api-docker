# pLannotate API

A simple FastAPI in docker to use pLannotate.


Local dependency management:

```bash
poetry add git+https://github.com/manulera/pLannotate --extras api
pip freeze > requirements.txt
```

Build and run image:

```
docker build -t manulera/plannotate-api .
docker run -d --name plannotate-api -p 8000:8000 manulera/plannotate-api
```

Go to http://localhost:8000 to see the API documentation.