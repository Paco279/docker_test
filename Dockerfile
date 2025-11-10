FROM python:3.12.9

RUN apt-get update && apt-get install -y curl build-essential

RUN curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION="--yes" bash
ENV PATH="/root/.rye/shims:/root/.rye/bin:$PATH"

COPY dist/*.whl .

RUN pip install *.whl

COPY . .

EXPOSE 8000

CMD ["rye", "run", "uvicorn", "src.docker_test.app:app", "--host", "0.0.0.0", "--port", "8000"]