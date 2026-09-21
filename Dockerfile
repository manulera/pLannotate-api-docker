FROM python:3.12-slim

WORKDIR /app
RUN apt-get update && apt-get install -y git curl ncbi-blast+ infernal ripgrep
RUN curl -L https://github.com/bbuchfink/diamond/releases/download/v2.1.10/diamond-linux64.tar.gz -o diamond.tar.gz
RUN tar -xzf diamond.tar.gz
RUN mv diamond /usr/local/bin/diamond
RUN rm diamond.tar.gz

# Test that it works
RUN diamond --help

# Install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# curl is required for this
RUN python -m plannotate.pLannotate setupdb

# The pLannotate release tarball ships some DB files with owner-only
# permissions (Rfam.clanin/Rfam.cm as uid 501, mode 600) — cmscan cannot
# open them as any other user and POST /annotate fails with HTTP 500 when
# the container runs as non-root. Make the static DBs world-readable.
RUN DBDIR="$(python -c 'import plannotate, os; print(os.path.join(os.path.dirname(plannotate.__file__), "data", "BLAST_dbs"))')" && chmod -R a+rX "$DBDIR"

# Remove git and curl
RUN apt-get remove -y git curl

COPY entrypoint.sh .
CMD ["sh", "entrypoint.sh"]
