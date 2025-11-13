FROM python:3.10-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
	PYTHONUNBUFFERED=1 \
	DEBIAN_FRONTEND=noninteractive\
	JUPYTER_TOKEN="waste_segmentation" \
	JUPYTER_PORT=8888

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential \
	libglib2.0-0 \
	libsm6 \
	libxext6 \
	libxrender-dev \
	&& rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt \
	&& pip install --no-cache-dir jupyter

COPY . .

EXPOSE ${JUPYTER_PORT}

CMD ["jupyter", "notebook", "notebooks/Waste_Segregation.ipynb", \
	"--ip=0.0.0.0", \
	"--no-browser", \
	"--allow-root", \
	"--port=8888"]
