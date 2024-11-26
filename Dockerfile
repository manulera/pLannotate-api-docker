FROM python:3.12-slim

WORKDIR /app
RUN apt-get update && apt-get install -y git curl ncbi-blast+ infernal ripgrep
RUN curl -L https://github.com/bbuchfink/diamond/releases/download/v2.1.10/diamond-linux64.tar.gz -o diamond.tar.gz
RUN tar -xzf diamond.tar.gz
RUN mv diamond /usr/local/bin/diamond

# Test that it works
RUN diamond --help

# Install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# curl is required for this
RUN python -m plannotate.pLannotate setupdb

# Remove git and curl
RUN apt-get remove -y git curl

COPY entrypoint.sh .
CMD ["sh", "entrypoint.sh"]
